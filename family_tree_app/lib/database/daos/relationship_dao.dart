// lib/database/daos/relationship_dao.dart
import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/all_tables.dart';

part 'relationship_dao.g.dart';

@DriftAccessor(tables: [Relationships])
class RelationshipDao extends DatabaseAccessor<AppDatabase>
    with _$RelationshipDaoMixin {
  RelationshipDao(super.db);

  // ── Streams ───────────────────────────────────────────────────────────────

  Stream<List<RelationshipData>> watchRelationshipsForPerson(String personId) =>
      (select(relationships)
            ..where(
              (r) =>
                  r.personId.equals(personId) & r.isDeleted.equals(false),
            ))
          .watch();

  // ── Queries ───────────────────────────────────────────────────────────────

  Future<List<RelationshipData>> getRelationshipsForPerson(String personId) =>
      (select(relationships)
            ..where(
              (r) =>
                  r.personId.equals(personId) & r.isDeleted.equals(false),
            ))
          .get();

  Future<List<RelationshipData>> getAllRelationshipsByTree(String treeId) =>
      (select(relationships)
            ..where((r) => r.treeId.equals(treeId) & r.isDeleted.equals(false)))
          .get();

  /// Returns IDs of parents of [personId] (where PARENT_OF points TO personId).
  Future<List<String>> getParentIdsOf(String personId) async {
    final rows = await (select(relationships)
          ..where(
            (r) =>
                r.relatedPersonId.equals(personId) &
                r.relationshipType.equals('PARENT_OF') &
                r.isDeleted.equals(false),
          ))
        .get();
    return rows.map((r) => r.personId).toList();
  }

  /// Returns IDs of children of [personId].
  Future<List<String>> getChildIdsOf(String personId) async {
    final rows = await (select(relationships)
          ..where(
            (r) =>
                r.personId.equals(personId) &
                r.relationshipType.equals('PARENT_OF') &
                r.isDeleted.equals(false),
          ))
        .get();
    return rows.map((r) => r.relatedPersonId).toList();
  }

  /// Returns IDs of spouses/partners of [personId].
  Future<List<String>> getSpouseIdsOf(String personId) async {
    final rows = await (select(relationships)
          ..where(
            (r) =>
                r.personId.equals(personId) &
                r.relationshipType.equals('SPOUSE_OF') &
                r.isDeleted.equals(false),
          ))
        .get();
    return rows.map((r) => r.relatedPersonId).toList();
  }

  Future<bool> relationshipExists(
    String personId,
    String relatedPersonId,
    String type,
    String? subType,
  ) async {
    final query = select(relationships)
      ..where(
        (r) =>
            r.personId.equals(personId) &
            r.relatedPersonId.equals(relatedPersonId) &
            r.relationshipType.equals(type) &
            r.isDeleted.equals(false),
      );
    final result = await query.getSingleOrNull();
    return result != null;
  }

  // ── Write ─────────────────────────────────────────────────────────────────

  Future<void> insertRelationship(RelationshipsCompanion entry) =>
      into(relationships).insert(entry, mode: InsertMode.insertOrIgnore);

  Future<bool> updateRelationship(RelationshipsCompanion entry) =>
      update(relationships).replace(entry);

  Future<int> softDeleteRelationship(String id) {
    final now = DateTime.now().toIso8601String();
    return (update(relationships)..where((r) => r.id.equals(id))).write(
      RelationshipsCompanion(
        isDeleted: const Value(true),
        deletedAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  Future<void> softDeleteAllRelationshipsForPerson(String personId) async {
    final now = DateTime.now().toIso8601String();
    await (update(relationships)
          ..where(
            (r) =>
                (r.personId.equals(personId) |
                    r.relatedPersonId.equals(personId)) &
                r.isDeleted.equals(false),
          ))
        .write(
      RelationshipsCompanion(
        isDeleted: const Value(true),
        deletedAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  Future<void> hardDeleteAllByTree(String treeId) =>
      (delete(relationships)..where((r) => r.treeId.equals(treeId))).go();
}
