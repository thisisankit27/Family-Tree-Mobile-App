// lib/database/app_database.dart
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/all_tables.dart';
import 'daos/family_tree_dao.dart';
import 'daos/person_dao.dart';
import 'daos/relationship_dao.dart';
import 'daos/media_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [FamilyTrees, Persons, Relationships, Medias],
  daos: [FamilyTreeDao, PersonDao, RelationshipDao, MediaDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          // Add future migration steps here as version increments
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
          await customStatement('PRAGMA journal_mode = WAL');
        },
      );
}

/// Opens a persistent SQLite connection in the app documents directory.
DatabaseConnection _openConnection() {
  return DatabaseConnection.delayed(Future(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'family_tree.sqlite'));
    return NativeDatabase.createInBackground(file, logStatements: false);
  }));
}
