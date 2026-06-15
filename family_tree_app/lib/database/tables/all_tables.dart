// lib/database/tables/all_tables.dart
import 'package:drift/drift.dart';

// ─── FamilyTrees ─────────────────────────────────────────────────────────────

@DataClassName('FamilyTreeData')
class FamilyTrees extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get rootPersonId => text().nullable()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// ─── Persons ─────────────────────────────────────────────────────────────────

@DataClassName('PersonData')
class Persons extends Table {
  // Identity
  TextColumn get id => text()();
  TextColumn get treeId => text()();

  // Name
  TextColumn get firstName => text()();
  TextColumn get middleName => text().nullable()();
  TextColumn get lastName => text().nullable()();
  TextColumn get maidenName => text().nullable()();
  TextColumn get nickname => text().nullable()();

  // Demographics
  TextColumn get gender => text().withDefault(const Constant('UNKNOWN'))();
  BoolColumn get isLiving => boolean().withDefault(const Constant(true))();

  // Dates
  TextColumn get birthDate => text().nullable()();
  BoolColumn get birthDateApprox => boolean().withDefault(const Constant(false))();
  TextColumn get deathDate => text().nullable()();
  BoolColumn get deathDateApprox => boolean().withDefault(const Constant(false))();

  // Places
  TextColumn get birthPlace => text().nullable()();
  TextColumn get deathPlace => text().nullable()();
  TextColumn get currentLocation => text().nullable()();

  // Personal
  TextColumn get occupation => text().nullable()();
  TextColumn get biography => text().nullable()();
  TextColumn get nationality => text().nullable()();
  TextColumn get education => text().nullable()();

  // Contact
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get website => text().nullable()();

  // Media
  TextColumn get profilePhotoPath => text().nullable()();

  // Soft delete
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  TextColumn get deletedAt => text().nullable()();

  // Audit
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// ─── Relationships ────────────────────────────────────────────────────────────

@DataClassName('RelationshipData')
class Relationships extends Table {
  TextColumn get id => text()();
  TextColumn get treeId => text()();

  // Directed edge
  TextColumn get personId => text()();         // subject
  TextColumn get relatedPersonId => text()();  // object

  // Type: PARENT_OF | CHILD_OF | SPOUSE_OF
  TextColumn get relationshipType => text()();

  // Sub-type: BIOLOGICAL | ADOPTIVE | FOSTER | STEP | MARRIED | DIVORCED …
  TextColumn get subType => text().nullable()();

  BoolColumn get isCurrent => boolean().withDefault(const Constant(true))();
  TextColumn get startDate => text().nullable()();
  BoolColumn get startDateApprox => boolean().withDefault(const Constant(false))();
  TextColumn get endDate => text().nullable()();
  BoolColumn get endDateApprox => boolean().withDefault(const Constant(false))();
  TextColumn get notes => text().nullable()();

  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  TextColumn get deletedAt => text().nullable()();

  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// ─── Medias ───────────────────────────────────────────────────────────────────

@DataClassName('MediaData')
class Medias extends Table {
  TextColumn get id => text()();
  TextColumn get treeId => text()();
  TextColumn get personId => text().nullable()();

  TextColumn get type => text().withDefault(const Constant('PHOTO'))();
  TextColumn get filePath => text()();
  TextColumn get fileName => text()();
  IntColumn get fileSizeBytes => integer().nullable()();
  TextColumn get mimeType => text().nullable()();

  TextColumn get title => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get dateTaken => text().nullable()();

  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  TextColumn get deletedAt => text().nullable()();

  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {id};
}
