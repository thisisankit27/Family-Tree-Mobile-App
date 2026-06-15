// lib/features/relationship/data/repositories/relationship_repository_impl.dart
import 'package:drift/drift.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/uuid_util.dart';
import '../../../../database/app_database.dart';
import '../../../../database/tables/all_tables.dart';
import '../../../member/domain/entities/person_entity.dart';
import '../../domain/entities/relationship_entity.dart';

class RelationshipRepository {
  RelationshipRepository(this._db);
  final AppDatabase _db;

  // ── Graph Traversal ───────────────────────────────────────────────────────

  Future<List<PersonEntity>> getParentsOf(String personId) async {
    final ids = await _db.relationshipDao.getParentIdsOf(personId);
    final rows = await _db.personDao.getPersonsByIds(ids);
    return rows.map(_personFromRow).toList();
  }

  Future<List<PersonEntity>> getChildrenOf(String personId) async {
    final ids = await _db.relationshipDao.getChildIdsOf(personId);
    final rows = await _db.personDao.getPersonsByIds(ids);
    return rows.map(_personFromRow).toList();
  }

  Future<List<PersonEntity>> getSpousesOf(String personId) async {
    final ids = await _db.relationshipDao.getSpouseIdsOf(personId);
    final rows = await _db.personDao.getPersonsByIds(ids);
    return rows.map(_personFromRow).toList();
  }

  /// Derives siblings: persons who share at least one parent with [personId].
  Future<List<SiblingEntry>> getSiblingsOf(String personId) async {
    final parentIds = await _db.relationshipDao.getParentIdsOf(personId);
    if (parentIds.isEmpty) return [];

    final sharedParentCount = <String, int>{};
    for (final parentId in parentIds) {
      final childIds = await _db.relationshipDao.getChildIdsOf(parentId);
      for (final childId in childIds) {
        if (childId != personId) {
          sharedParentCount[childId] = (sharedParentCount[childId] ?? 0) + 1;
        }
      }
    }

    return sharedParentCount.entries.map((e) {
      final type = e.value == parentIds.length
          ? SiblingType.full
          : SiblingType.half;
      return SiblingEntry(
        personId: e.key,
        siblingType: type,
        sharedParentCount: e.value,
      );
    }).toList();
  }

  Future<List<RelationshipEntity>> getRelationshipsForPerson(
      String personId) async {
    final rows =
        await _db.relationshipDao.getRelationshipsForPerson(personId);
    return rows.map(_toRelEntity).toList();
  }

  Future<List<RelationshipEntity>> getAllRelationshipsByTree(
      String treeId) async {
    final rows =
        await _db.relationshipDao.getAllRelationshipsByTree(treeId);
    return rows.map(_toRelEntity).toList();
  }

  // ── Write ─────────────────────────────────────────────────────────────────

  /// Adds a parent-child relationship. Stores BOTH directed edges.
  Future<void> addParentChildRelationship({
    required String treeId,
    required String parentId,
    required String childId,
    required ParentSubType subType,
  }) async {
    final now = DateTime.now().toIso8601String();

    await _db.transaction(() async {
      // Edge 1: Parent → Child (PARENT_OF)
      await _db.relationshipDao.insertRelationship(
        RelationshipsCompanion.insert(
          id: UuidUtil.generate(),
          treeId: treeId,
          personId: parentId,
          relatedPersonId: childId,
          relationshipType: RelationshipType.parentOf.value,
          subType: Value(subType.value),
          createdAt: now,
          updatedAt: now,
        ),
      );
      // Edge 2: Child → Parent (CHILD_OF)
      await _db.relationshipDao.insertRelationship(
        RelationshipsCompanion.insert(
          id: UuidUtil.generate(),
          treeId: treeId,
          personId: childId,
          relatedPersonId: parentId,
          relationshipType: RelationshipType.childOf.value,
          subType: Value(subType.value),
          createdAt: now,
          updatedAt: now,
        ),
      );
    });
  }

  /// Adds a spouse relationship. Stores BOTH directed edges.
  Future<void> addSpouseRelationship({
    required String treeId,
    required String personAId,
    required String personBId,
    required SpouseSubType subType,
    String? startDate,
    bool startDateApprox = false,
    String? endDate,
    bool endDateApprox = false,
    String? notes,
  }) async {
    final now = DateTime.now().toIso8601String();

    await _db.transaction(() async {
      // Edge A → B
      await _db.relationshipDao.insertRelationship(
        RelationshipsCompanion.insert(
          id: UuidUtil.generate(),
          treeId: treeId,
          personId: personAId,
          relatedPersonId: personBId,
          relationshipType: RelationshipType.spouseOf.value,
          subType: Value(subType.value),
          startDate: Value(startDate),
          startDateApprox: Value(startDateApprox),
          endDate: Value(endDate),
          endDateApprox: Value(endDateApprox),
          notes: Value(notes),
          createdAt: now,
          updatedAt: now,
        ),
      );
      // Edge B → A
      await _db.relationshipDao.insertRelationship(
        RelationshipsCompanion.insert(
          id: UuidUtil.generate(),
          treeId: treeId,
          personId: personBId,
          relatedPersonId: personAId,
          relationshipType: RelationshipType.spouseOf.value,
          subType: Value(subType.value),
          startDate: Value(startDate),
          startDateApprox: Value(startDateApprox),
          endDate: Value(endDate),
          endDateApprox: Value(endDateApprox),
          notes: Value(notes),
          createdAt: now,
          updatedAt: now,
        ),
      );
    });
  }

  Future<void> deleteRelationship(String id) =>
      _db.relationshipDao.softDeleteRelationship(id);

  // ── Mappers ───────────────────────────────────────────────────────────────

  RelationshipEntity _toRelEntity(RelationshipData row) => RelationshipEntity(
        id: row.id,
        treeId: row.treeId,
        personId: row.personId,
        relatedPersonId: row.relatedPersonId,
        relationshipType:
            RelationshipType.fromValue(row.relationshipType),
        subType: row.subType,
        isCurrent: row.isCurrent,
        startDate: row.startDate,
        startDateApprox: row.startDateApprox,
        endDate: row.endDate,
        endDateApprox: row.endDateApprox,
        notes: row.notes,
        createdAt: DateTime.parse(row.createdAt),
        updatedAt: DateTime.parse(row.updatedAt),
      );

  PersonEntity _personFromRow(row) => PersonEntity(
        id: row.id,
        treeId: row.treeId,
        firstName: row.firstName,
        middleName: row.middleName,
        lastName: row.lastName,
        maidenName: row.maidenName,
        nickname: row.nickname,
        gender: Gender.fromValue(row.gender),
        isLiving: row.isLiving,
        birthDate: row.birthDate,
        birthDateApprox: row.birthDateApprox,
        deathDate: row.deathDate,
        deathDateApprox: row.deathDateApprox,
        birthPlace: row.birthPlace,
        deathPlace: row.deathPlace,
        currentLocation: row.currentLocation,
        occupation: row.occupation,
        biography: row.biography,
        nationality: row.nationality,
        education: row.education,
        email: row.email,
        phone: row.phone,
        address: row.address,
        website: row.website,
        profilePhotoPath: row.profilePhotoPath,
        createdAt: DateTime.parse(row.createdAt),
        updatedAt: DateTime.parse(row.updatedAt),
      );
}
