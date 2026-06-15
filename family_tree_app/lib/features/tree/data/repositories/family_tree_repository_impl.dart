// lib/features/tree/data/repositories/family_tree_repository_impl.dart
import 'package:drift/drift.dart';
import '../../../../core/utils/uuid_util.dart';
import '../../../../database/app_database.dart';
import '../../../../database/tables/all_tables.dart';
import '../../domain/entities/family_tree_entity.dart';

class FamilyTreeRepository {
  FamilyTreeRepository(this._db);
  final AppDatabase _db;

  // ── Streams ───────────────────────────────────────────────────────────────

  Stream<List<FamilyTreeEntity>> watchAllTrees() =>
      _db.familyTreeDao.watchAllTrees().map(
            (rows) => rows.map(_toEntity).toList(),
          );

  // ── Read ─────────────────────────────────────────────────────────────────

  Future<List<FamilyTreeEntity>> getAllTrees() async {
    final rows = await _db.familyTreeDao.getAllTrees();
    final entities = <FamilyTreeEntity>[];
    for (final row in rows) {
      final count = await _db.personDao.countPersonsByTree(row.id);
      entities.add(_toEntity(row).copyWith(memberCount: count));
    }
    return entities;
  }

  Future<FamilyTreeEntity?> getTreeById(String id) async {
    final row = await _db.familyTreeDao.getTreeById(id);
    if (row == null) return null;
    final count = await _db.personDao.countPersonsByTree(id);
    return _toEntity(row).copyWith(memberCount: count);
  }

  // ── Write ─────────────────────────────────────────────────────────────────

  Future<FamilyTreeEntity> createTree({
    required String name,
    String? description,
  }) async {
    final now = DateTime.now();
    final entity = FamilyTreeEntity(
      id: UuidUtil.generate(),
      name: name,
      description: description,
      createdAt: now,
      updatedAt: now,
    );
    await _db.familyTreeDao.insertTree(
      FamilyTreesCompanion.insert(
        id: entity.id,
        name: entity.name,
        description: Value(entity.description),
        createdAt: entity.createdAt.toIso8601String(),
        updatedAt: entity.updatedAt.toIso8601String(),
      ),
    );
    return entity;
  }

  Future<void> updateTree(FamilyTreeEntity entity) async {
    await _db.familyTreeDao.updateTree(
      FamilyTreesCompanion(
        id: Value(entity.id),
        name: Value(entity.name),
        description: Value(entity.description),
        rootPersonId: Value(entity.rootPersonId),
        updatedAt: Value(DateTime.now().toIso8601String()),
      ),
    );
  }

  Future<void> deleteTree(String id) async {
    await _db.transaction(() async {
      await _db.relationshipDao.hardDeleteAllByTree(id);
      await _db.mediaDao.hardDeleteAllByTree(id);
      await _db.personDao.hardDeleteAllByTree(id);
      await _db.familyTreeDao.deleteTree(id);
    });
  }

  Future<void> setRootPerson(String treeId, String? personId) =>
      _db.familyTreeDao.setRootPerson(treeId, personId);

  // ── Mapper ────────────────────────────────────────────────────────────────

  FamilyTreeEntity _toEntity(FamilyTreeData row) => FamilyTreeEntity(
        id: row.id,
        name: row.name,
        description: row.description,
        rootPersonId: row.rootPersonId,
        createdAt: DateTime.parse(row.createdAt),
        updatedAt: DateTime.parse(row.updatedAt),
      );
}
