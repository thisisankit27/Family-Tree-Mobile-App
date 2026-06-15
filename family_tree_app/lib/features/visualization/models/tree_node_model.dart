// lib/features/visualization/models/tree_node_model.dart
import 'dart:ui';
import '../../member/domain/entities/person_entity.dart';

enum EdgeType { parentChild, spouse }

/// A positioned node in the rendered family tree.
class TreeNode {
  TreeNode({
    required this.person,
    required this.generation,
    this.x = 0,
    this.y = 0,
  });

  final PersonEntity person;
  final int generation;
  double x;
  double y;

  /// ID of the spouse this node is paired with (displayed side-by-side).
  String? spouseNodeId;

  String get id => person.id;

  Offset get center => Offset(x + nodeWidth / 2, y + nodeHeight / 2);
  Offset get bottomCenter => Offset(x + nodeWidth / 2, y + nodeHeight);
  Offset get topCenter => Offset(x + nodeWidth / 2, y);

  static const double nodeWidth = 130.0;
  static const double nodeHeight = 84.0;
}

/// A directed visual connection between two tree nodes.
class TreeEdge {
  const TreeEdge({
    required this.fromId,
    required this.toId,
    required this.type,
  });

  final String fromId;
  final String toId;
  final EdgeType type;
}

/// Complete layout result passed to the canvas painter.
class TreeLayoutResult {
  const TreeLayoutResult({
    required this.nodes,
    required this.edges,
    required this.canvasWidth,
    required this.canvasHeight,
  });

  final Map<String, TreeNode> nodes;
  final List<TreeEdge> edges;
  final double canvasWidth;
  final double canvasHeight;

  bool get isEmpty => nodes.isEmpty;
}
