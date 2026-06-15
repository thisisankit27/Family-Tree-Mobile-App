// lib/features/visualization/algorithms/family_tree_layout.dart
import '../../member/domain/entities/person_entity.dart';
import '../../relationship/domain/entities/relationship_entity.dart';
import '../../tree/presentation/providers/providers.dart';
import '../models/tree_node_model.dart';
import '../../../../core/constants/app_constants.dart';

class FamilyTreeLayout {
  static const double _nodeW = TreeNode.nodeWidth;
  static const double _nodeH = TreeNode.nodeHeight;
  static const double _hGap = 24.0;      // horizontal gap between nodes
  static const double _vGap = 100.0;     // vertical gap between generations
  static const double _spouseGap = 12.0; // gap within a couple

  /// Compute layout for the entire tree.
  /// [anchor] is the person to center the tree on. Falls back to first person.
  TreeLayoutResult compute(TreeGraphData data, String? anchorId) {
    if (data.persons.isEmpty) {
      return const TreeLayoutResult(
          nodes: {}, edges: [], canvasWidth: 0, canvasHeight: 0);
    }

    // ── Build adjacency maps ─────────────────────────────────────────────

    // personId → [childIds]  (PARENT_OF edges)
    final childrenOf = <String, Set<String>>{};
    // personId → [parentIds]
    final parentsOf = <String, Set<String>>{};
    // personId → [spouseIds] (SPOUSE_OF edges)
    final spousesOf = <String, Set<String>>{};

    for (final rel in data.relationships) {
      if (rel.relationshipType == RelationshipType.parentOf) {
        childrenOf.putIfAbsent(rel.personId, () => {}).add(rel.relatedPersonId);
        parentsOf.putIfAbsent(rel.relatedPersonId, () => {}).add(rel.personId);
      } else if (rel.relationshipType == RelationshipType.spouseOf) {
        spousesOf.putIfAbsent(rel.personId, () => {}).add(rel.relatedPersonId);
      }
    }

    final personMap = {for (final p in data.persons) p.id: p};

    // ── Assign generations via BFS ────────────────────────────────────────

    final anchor = anchorId != null && personMap.containsKey(anchorId)
        ? personMap[anchorId]!
        : data.persons.first;

    final generationOf = <String, int>{};
    generationOf[anchor.id] = 0;

    // Assign spouses the same generation
    final queue = <String>[anchor.id];
    final visited = <String>{anchor.id};

    while (queue.isNotEmpty) {
      final currentId = queue.removeAt(0);
      final gen = generationOf[currentId]!;

      // Spouses → same generation
      for (final spouseId in spousesOf[currentId] ?? <String>{}) {
        if (!visited.contains(spouseId) && personMap.containsKey(spouseId)) {
          visited.add(spouseId);
          generationOf[spouseId] = gen;
          queue.add(spouseId);
        }
      }

      // Children → gen + 1
      for (final childId in childrenOf[currentId] ?? <String>{}) {
        if (!visited.contains(childId) && personMap.containsKey(childId)) {
          visited.add(childId);
          generationOf[childId] = gen + 1;
          queue.add(childId);
        }
      }

      // Parents → gen - 1
      for (final parentId in parentsOf[currentId] ?? <String>{}) {
        if (!visited.contains(parentId) && personMap.containsKey(parentId)) {
          visited.add(parentId);
          generationOf[parentId] = gen - 1;
          queue.add(parentId);
        }
      }
    }

    // Include any disconnected persons at generation 99 (won't render in
    // connected view, but ensures they're in the map)
    for (final p in data.persons) {
      generationOf.putIfAbsent(p.id, () => 0);
    }

    // ── Group by generation ───────────────────────────────────────────────

    final byGen = <int, List<String>>{};
    for (final e in generationOf.entries) {
      byGen.putIfAbsent(e.value, () => []).add(e.key);
    }

    // ── Build couple groups within each generation ────────────────────────
    // A couple = (personA, personB) where they are spouses AND both same gen.

    final coupleMembers = <String>{}; // track who has been paired
    final slotsByGen = <int, List<_Slot>>{};

    for (final gen in byGen.keys) {
      final ids = byGen[gen]!;
      final slots = <_Slot>[];

      for (final id in ids) {
        if (coupleMembers.contains(id)) continue;
        final mySpouses = spousesOf[id] ?? {};
        final spouseInGen = mySpouses
            .where((s) => generationOf[s] == gen && !coupleMembers.contains(s))
            .toList();

        if (spouseInGen.isNotEmpty) {
          final partner = spouseInGen.first;
          coupleMembers.add(id);
          coupleMembers.add(partner);
          slots.add(_Slot.couple(id, partner));
        } else if (!coupleMembers.contains(id)) {
          coupleMembers.add(id);
          slots.add(_Slot.single(id));
        }
      }
      slotsByGen[gen] = slots;
    }

    // ── Assign X positions ────────────────────────────────────────────────

    // Canvas width is driven by the widest generation
    double maxRowWidth = 0;
    final rowWidths = <int, double>{};

    for (final e in slotsByGen.entries) {
      final rowWidth = _computeRowWidth(e.value);
      rowWidths[e.key] = rowWidth;
      if (rowWidth > maxRowWidth) maxRowWidth = rowWidth;
    }

    final canvasWidth = maxRowWidth + 200;
    final canvasCenterX = canvasWidth / 2;

    final nodes = <String, TreeNode>{};

    final sortedGens = slotsByGen.keys.toList()..sort();
    final minGen = sortedGens.first;

    for (final gen in sortedGens) {
      final slots = slotsByGen[gen]!;
      final rowWidth = rowWidths[gen]!;
      var slotX = canvasCenterX - rowWidth / 2;
      final y = (gen - minGen) * (_nodeH + _vGap) + 40;

      for (final slot in slots) {
        if (slot.isCoupled) {
          final node1 = TreeNode(
            person: personMap[slot.id1]!,
            generation: gen,
            x: slotX,
            y: y,
          );
          final node2 = TreeNode(
            person: personMap[slot.id2!]!,
            generation: gen,
            x: slotX + _nodeW + _spouseGap,
            y: y,
          );
          node1.spouseNodeId = slot.id2;
          node2.spouseNodeId = slot.id1;
          nodes[slot.id1] = node1;
          nodes[slot.id2!] = node2;
          slotX += _nodeW * 2 + _spouseGap + _hGap;
        } else {
          final node = TreeNode(
            person: personMap[slot.id1]!,
            generation: gen,
            x: slotX,
            y: y,
          );
          nodes[slot.id1] = node;
          slotX += _nodeW + _hGap;
        }
      }
    }

    // ── Build edges ───────────────────────────────────────────────────────

    final edges = <TreeEdge>[];
    final addedEdges = <String>{};

    // Spouse edges
    for (final node in nodes.values) {
      if (node.spouseNodeId != null) {
        final edgeKey = [node.id, node.spouseNodeId!]..sort();
        final key = edgeKey.join('-');
        if (!addedEdges.contains(key)) {
          addedEdges.add(key);
          edges.add(TreeEdge(
              fromId: node.id,
              toId: node.spouseNodeId!,
              type: EdgeType.spouse));
        }
      }
    }

    // Parent-child edges (only draw PARENT_OF from nodes that are in the layout)
    for (final rel in data.relationships) {
      if (rel.relationshipType != RelationshipType.parentOf) continue;
      if (!nodes.containsKey(rel.personId)) continue;
      if (!nodes.containsKey(rel.relatedPersonId)) continue;
      edges.add(TreeEdge(
          fromId: rel.personId,
          toId: rel.relatedPersonId,
          type: EdgeType.parentChild));
    }

    final canvasHeight =
        (sortedGens.length) * (_nodeH + _vGap) + 200;

    return TreeLayoutResult(
      nodes: nodes,
      edges: edges,
      canvasWidth: canvasWidth,
      canvasHeight: canvasHeight,
    );
  }

  double _computeRowWidth(List<_Slot> slots) {
    double width = 0;
    for (int i = 0; i < slots.length; i++) {
      final slot = slots[i];
      width += slot.isCoupled
          ? _nodeW * 2 + _spouseGap
          : _nodeW;
      if (i < slots.length - 1) width += _hGap;
    }
    return width;
  }
}

class _Slot {
  final String id1;
  final String? id2;
  bool get isCoupled => id2 != null;

  const _Slot.single(this.id1) : id2 = null;
  const _Slot.couple(this.id1, this.id2);
}
