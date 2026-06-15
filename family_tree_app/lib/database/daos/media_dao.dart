// lib/database/daos/media_dao.dart
import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/all_tables.dart';

part 'media_dao.g.dart';

@DriftAccessor(tables: [Medias])
class MediaDao extends DatabaseAccessor<AppDatabase> with _$MediaDaoMixin {
  MediaDao(super.db);

  Future<List<MediaData>> getMediaForPerson(String personId) =>
      (select(medias)
            ..where(
              (m) => m.personId.equals(personId) & m.isDeleted.equals(false),
            )
            ..orderBy([(m) => OrderingTerm.desc(m.createdAt)]))
          .get();

  Future<List<MediaData>> getAllMediaByTree(String treeId) =>
      (select(medias)
            ..where((m) => m.treeId.equals(treeId) & m.isDeleted.equals(false)))
          .get();

  Future<void> insertMedia(MediasCompanion entry) =>
      into(medias).insert(entry);

  Future<int> softDeleteMedia(String id) {
    final now = DateTime.now().toIso8601String();
    return (update(medias)..where((m) => m.id.equals(id))).write(
      MediasCompanion(
        isDeleted: const Value(true),
        deletedAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  Future<void> hardDeleteAllByTree(String treeId) =>
      (delete(medias)..where((m) => m.treeId.equals(treeId))).go();
}
