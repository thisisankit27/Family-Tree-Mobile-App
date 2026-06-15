// lib/core/constants/app_constants.dart
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Family Tree';
  static const String appVersion = '1.0.0';

  // Database
  static const String dbName = 'family_tree.sqlite';
  static const int dbSchemaVersion = 1;

  // JSON Export
  static const int jsonSchemaVersion = 1;
  static const String exportFileName = 'family_tree_backup';

  // UI
  static const double nodeWidth = 130.0;
  static const double nodeHeight = 85.0;
  static const double generationGap = 160.0;
  static const double siblingGap = 20.0;
  static const double canvasSize = 5000.0;
  static const double canvasOrigin = 2500.0;

  // Limits
  static const int maxGenerationsUp = 6;
  static const int maxGenerationsDown = 6;
  static const int softDeleteRetentionDays = 30;
}

// ─── Gender ──────────────────────────────────────────────────────────────────

enum Gender {
  male('MALE', 'Male'),
  female('FEMALE', 'Female'),
  nonBinary('NON_BINARY', 'Non-Binary'),
  other('OTHER', 'Other'),
  unknown('UNKNOWN', 'Unknown');

  const Gender(this.value, this.displayName);
  final String value;
  final String displayName;

  static Gender fromValue(String value) {
    return Gender.values.firstWhere(
      (g) => g.value == value.toUpperCase(),
      orElse: () => Gender.unknown,
    );
  }
}

// ─── RelationshipType ────────────────────────────────────────────────────────

enum RelationshipType {
  parentOf('PARENT_OF'),
  childOf('CHILD_OF'),
  spouseOf('SPOUSE_OF');

  const RelationshipType(this.value);
  final String value;

  static RelationshipType fromValue(String value) {
    return RelationshipType.values.firstWhere(
      (r) => r.value == value.toUpperCase(),
      orElse: () => RelationshipType.parentOf,
    );
  }
}

// ─── ParentSubType ───────────────────────────────────────────────────────────

enum ParentSubType {
  biological('BIOLOGICAL', 'Biological'),
  adoptive('ADOPTIVE', 'Adoptive'),
  foster('FOSTER', 'Foster'),
  step('STEP', 'Step');

  const ParentSubType(this.value, this.displayName);
  final String value;
  final String displayName;

  static ParentSubType fromValue(String value) {
    return ParentSubType.values.firstWhere(
      (p) => p.value == value.toUpperCase(),
      orElse: () => ParentSubType.biological,
    );
  }
}

// ─── SpouseSubType ───────────────────────────────────────────────────────────

enum SpouseSubType {
  married('MARRIED', 'Married'),
  domesticPartner('DOMESTIC_PARTNER', 'Domestic Partner'),
  separated('SEPARATED', 'Separated'),
  divorced('DIVORCED', 'Divorced'),
  widowed('WIDOWED', 'Widowed');

  const SpouseSubType(this.value, this.displayName);
  final String value;
  final String displayName;

  static SpouseSubType fromValue(String value) {
    return SpouseSubType.values.firstWhere(
      (s) => s.value == value.toUpperCase(),
      orElse: () => SpouseSubType.married,
    );
  }
}

// ─── SiblingType (derived) ───────────────────────────────────────────────────

enum SiblingType {
  full('Full Sibling'),
  half('Half Sibling'),
  step('Step Sibling');

  const SiblingType(this.displayName);
  final String displayName;
}
