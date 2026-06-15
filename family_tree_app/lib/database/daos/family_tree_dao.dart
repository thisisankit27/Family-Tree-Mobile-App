// lib/database/daos/family_tree_dao.dart
import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/all_tables.dart';

part 'family_tree_dao.g.dart';

@DriftAccessor(tables: [FamilyTrees])
class FamilyTreeDao extends DatabaseAccessor<AppDatabase>
    with _$FamilyTreeDaoMixin {
  FamilyTreeDao(super.db);

  // ── Streams (reactive) ────────────────────────────────────────────────────

  Stream<List<FamilyTreeData>> watchAllTrees() =>
      (select(familyTrees)..orderBy([(t) => OrderingTerm.asc(t.name)])).watch();

  // ── Queries ───────────────────────────────────────────────────────────────

  Future<List<FamilyTreeData>> getAllTrees() =>
      (select(familyTrees)..orderBy([(t) => OrderingTerm.asc(t.name)])).get();

  Future<FamilyTreeData?> getTreeById(String id) =>
      (select(familyTrees)..where((t) => t.id.equals(id))).getSingleOrNull();

  // ── Write ─────────────────────────────────────────────────────────────────

  Future<void> insertTree(FamilyTreesCompanion entry) =>
      into(familyTrees).insert(entry);

  Future<bool> updateTree(FamilyTreesCompanion entry) =>
      update(familyTrees).replace(entry);

  Future<int> deleteTree(String id) =>
      (delete(familyTrees)..where((t) => t.id.equals(id))).go();

  Future<void> setRootPerson(String treeId, String? personId) =>
      (update(familyTrees)..where((t) => t.id.equals(treeId))).write(
        FamilyTreesCompanion(
          rootPersonId: Value(personId),
          updatedAt: Value(DateTime.now().toIso8601String()),
        ),
      );
}
