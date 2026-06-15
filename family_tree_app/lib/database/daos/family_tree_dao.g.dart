// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_tree_dao.dart';

// ignore_for_file: type=lint
mixin _$FamilyTreeDaoMixin on DatabaseAccessor<AppDatabase> {
  $FamilyTreesTable get familyTrees => attachedDatabase.familyTrees;
  FamilyTreeDaoManager get managers => FamilyTreeDaoManager(this);
}

class FamilyTreeDaoManager {
  final _$FamilyTreeDaoMixin _db;
  FamilyTreeDaoManager(this._db);
  $$FamilyTreesTableTableManager get familyTrees =>
      $$FamilyTreesTableTableManager(_db.attachedDatabase, _db.familyTrees);
}
