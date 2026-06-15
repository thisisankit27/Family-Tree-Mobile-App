// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relationship_dao.dart';

// ignore_for_file: type=lint
mixin _$RelationshipDaoMixin on DatabaseAccessor<AppDatabase> {
  $RelationshipsTable get relationships => attachedDatabase.relationships;
  RelationshipDaoManager get managers => RelationshipDaoManager(this);
}

class RelationshipDaoManager {
  final _$RelationshipDaoMixin _db;
  RelationshipDaoManager(this._db);
  $$RelationshipsTableTableManager get relationships =>
      $$RelationshipsTableTableManager(_db.attachedDatabase, _db.relationships);
}
