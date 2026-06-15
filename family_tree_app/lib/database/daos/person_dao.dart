// lib/database/daos/person_dao.dart
import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/all_tables.dart';

part 'person_dao.g.dart';

@DriftAccessor(tables: [Persons])
class PersonDao extends DatabaseAccessor<AppDatabase> with _$PersonDaoMixin {
  PersonDao(super.db);

  // ── Streams ───────────────────────────────────────────────────────────────

  Stream<List<PersonData>> watchPersonsByTree(String treeId) =>
      (select(persons)
            ..where((p) => p.treeId.equals(treeId) & p.isDeleted.equals(false))
            ..orderBy([(p) => OrderingTerm.asc(p.firstName)]))
          .watch();

  // ── Queries ───────────────────────────────────────────────────────────────

  Future<List<PersonData>> getPersonsByTree(String treeId) =>
      (select(persons)
            ..where((p) => p.treeId.equals(treeId) & p.isDeleted.equals(false))
            ..orderBy([(p) => OrderingTerm.asc(p.firstName)]))
          .get();

  Future<PersonData?> getPersonById(String id) =>
      (select(persons)..where((p) => p.id.equals(id))).getSingleOrNull();

  Future<List<PersonData>> getPersonsByIds(List<String> ids) {
    if (ids.isEmpty) return Future.value([]);
    return (select(persons)
          ..where((p) => p.id.isIn(ids) & p.isDeleted.equals(false)))
        .get();
  }

  Future<List<PersonData>> searchPersons(String treeId, String query) {
    final q = '%${query.toLowerCase()}%';
    return (select(persons)
          ..where(
            (p) =>
                p.treeId.equals(treeId) &
                p.isDeleted.equals(false) &
                (p.firstName.lower().like(q) |
                    p.lastName.lower().like(q) |
                    p.nickname.lower().like(q) |
                    p.occupation.lower().like(q)),
          )
          ..orderBy([(p) => OrderingTerm.asc(p.firstName)]))
        .get();
  }

  Future<List<PersonData>> getDeletedPersons(String treeId) =>
      (select(persons)
            ..where((p) => p.treeId.equals(treeId) & p.isDeleted.equals(true))
            ..orderBy([(p) => OrderingTerm.desc(p.deletedAt)]))
          .get();

  Future<int> countPersonsByTree(String treeId) async {
    final count = persons.id.count();
    final query = selectOnly(persons)
      ..addColumns([count])
      ..where(persons.treeId.equals(treeId) & persons.isDeleted.equals(false));
    final row = await query.getSingleOrNull();
    return row?.read(count) ?? 0;
  }

  // ── Write ─────────────────────────────────────────────────────────────────

  Future<void> insertPerson(PersonsCompanion entry) =>
      into(persons).insert(entry);

  Future<bool> updatePerson(PersonsCompanion entry) =>
      update(persons).replace(entry);

  Future<int> softDeletePerson(String id) {
    final now = DateTime.now().toIso8601String();
    return (update(persons)..where((p) => p.id.equals(id))).write(
      PersonsCompanion(
        isDeleted: const Value(true),
        deletedAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  Future<int> hardDeletePerson(String id) =>
      (delete(persons)..where((p) => p.id.equals(id))).go();

  Future<int> restorePerson(String id) =>
      (update(persons)..where((p) => p.id.equals(id))).write(
        PersonsCompanion(
          isDeleted: const Value(false),
          deletedAt: const Value(null),
          updatedAt: Value(DateTime.now().toIso8601String()),
        ),
      );

  Future<void> hardDeleteAllByTree(String treeId) =>
      (delete(persons)..where((p) => p.treeId.equals(treeId))).go();
}
