// lib/features/member/data/repositories/person_repository_impl.dart
import 'package:drift/drift.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/uuid_util.dart';
import '../../../../database/app_database.dart';
import '../../../../database/tables/all_tables.dart';
import '../../domain/entities/person_entity.dart';

class PersonRepository {
  PersonRepository(this._db);
  final AppDatabase _db;

  // ── Streams ───────────────────────────────────────────────────────────────

  Stream<List<PersonEntity>> watchPersonsByTree(String treeId) =>
      _db.personDao
          .watchPersonsByTree(treeId)
          .map((rows) => rows.map(_toEntity).toList());

  // ── Read ─────────────────────────────────────────────────────────────────

  Future<List<PersonEntity>> getPersonsByTree(String treeId) async {
    final rows = await _db.personDao.getPersonsByTree(treeId);
    return rows.map(_toEntity).toList();
  }

  Future<PersonEntity?> getPersonById(String id) async {
    final row = await _db.personDao.getPersonById(id);
    return row != null ? _toEntity(row) : null;
  }

  Future<List<PersonEntity>> getPersonsByIds(List<String> ids) async {
    final rows = await _db.personDao.getPersonsByIds(ids);
    return rows.map(_toEntity).toList();
  }

  Future<List<PersonEntity>> searchPersons(
      String treeId, String query) async {
    if (query.trim().isEmpty) return getPersonsByTree(treeId);
    final rows = await _db.personDao.searchPersons(treeId, query);
    return rows.map(_toEntity).toList();
  }

  // ── Write ─────────────────────────────────────────────────────────────────

  Future<PersonEntity> createPerson({
    required String treeId,
    required String firstName,
    String? middleName,
    String? lastName,
    String? maidenName,
    String? nickname,
    Gender gender = Gender.unknown,
    bool isLiving = true,
    String? birthDate,
    bool birthDateApprox = false,
    String? deathDate,
    bool deathDateApprox = false,
    String? birthPlace,
    String? deathPlace,
    String? currentLocation,
    String? occupation,
    String? biography,
    String? nationality,
    String? education,
    String? email,
    String? phone,
    String? address,
    String? website,
    String? profilePhotoPath,
  }) async {
    final now = DateTime.now();
    final entity = PersonEntity(
      id: UuidUtil.generate(),
      treeId: treeId,
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      maidenName: maidenName,
      nickname: nickname,
      gender: gender,
      isLiving: isLiving,
      birthDate: birthDate,
      birthDateApprox: birthDateApprox,
      deathDate: deathDate,
      deathDateApprox: deathDateApprox,
      birthPlace: birthPlace,
      deathPlace: deathPlace,
      currentLocation: currentLocation,
      occupation: occupation,
      biography: biography,
      nationality: nationality,
      education: education,
      email: email,
      phone: phone,
      address: address,
      website: website,
      profilePhotoPath: profilePhotoPath,
      createdAt: now,
      updatedAt: now,
    );
    await _db.personDao.insertPerson(_toCompanion(entity));
    return entity;
  }

  Future<void> updatePerson(PersonEntity entity) async {
    final updated = entity.copyWith(updatedAt: DateTime.now());
    await _db.personDao.updatePerson(_toCompanion(updated));
  }

  Future<void> softDeletePerson(String id) async {
    await _db.personDao.softDeletePerson(id);
    await _db.relationshipDao.softDeleteAllRelationshipsForPerson(id);
  }

  Future<void> hardDeletePerson(String id) async {
    await _db.personDao.hardDeletePerson(id);
    await _db.relationshipDao.softDeleteAllRelationshipsForPerson(id);
  }

  Future<void> restorePerson(String id) =>
      _db.personDao.restorePerson(id);

  // ── Mappers ───────────────────────────────────────────────────────────────

  PersonEntity _toEntity(PersonData row) => PersonEntity(
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

  PersonsCompanion _toCompanion(PersonEntity e) => PersonsCompanion(
        id: Value(e.id),
        treeId: Value(e.treeId),
        firstName: Value(e.firstName),
        middleName: Value(e.middleName),
        lastName: Value(e.lastName),
        maidenName: Value(e.maidenName),
        nickname: Value(e.nickname),
        gender: Value(e.gender.value),
        isLiving: Value(e.isLiving),
        birthDate: Value(e.birthDate),
        birthDateApprox: Value(e.birthDateApprox),
        deathDate: Value(e.deathDate),
        deathDateApprox: Value(e.deathDateApprox),
        birthPlace: Value(e.birthPlace),
        deathPlace: Value(e.deathPlace),
        currentLocation: Value(e.currentLocation),
        occupation: Value(e.occupation),
        biography: Value(e.biography),
        nationality: Value(e.nationality),
        education: Value(e.education),
        email: Value(e.email),
        phone: Value(e.phone),
        address: Value(e.address),
        website: Value(e.website),
        profilePhotoPath: Value(e.profilePhotoPath),
        createdAt: Value(e.createdAt.toIso8601String()),
        updatedAt: Value(e.updatedAt.toIso8601String()),
      );
}
