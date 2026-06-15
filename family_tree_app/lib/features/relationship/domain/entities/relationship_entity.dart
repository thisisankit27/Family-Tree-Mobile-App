// lib/features/relationship/domain/entities/relationship_entity.dart
import '../../../../core/constants/app_constants.dart';

class RelationshipEntity {
  final String id;
  final String treeId;
  final String personId;
  final String relatedPersonId;
  final RelationshipType relationshipType;
  final String? subType;
  final bool isCurrent;
  final String? startDate;
  final bool startDateApprox;
  final String? endDate;
  final bool endDateApprox;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RelationshipEntity({
    required this.id,
    required this.treeId,
    required this.personId,
    required this.relatedPersonId,
    required this.relationshipType,
    this.subType,
    this.isCurrent = true,
    this.startDate,
    this.startDateApprox = false,
    this.endDate,
    this.endDateApprox = false,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  // ── Computed ──────────────────────────────────────────────────────────────

  String get displayLabel {
    switch (relationshipType) {
      case RelationshipType.parentOf:
        final sub = _parentSubLabel();
        return '$sub Parent';
      case RelationshipType.childOf:
        final sub = _parentSubLabel();
        return '$sub Child';
      case RelationshipType.spouseOf:
        return _spouseSubLabel();
    }
  }

  String _parentSubLabel() {
    if (subType == null) return '';
    final pt = ParentSubType.fromValue(subType!);
    return pt.displayName;
  }

  String _spouseSubLabel() {
    if (subType == null) return 'Spouse';
    final st = SpouseSubType.fromValue(subType!);
    return st.displayName;
  }

  // ── copyWith ─────────────────────────────────────────────────────────────

  RelationshipEntity copyWith({
    String? id,
    String? treeId,
    String? personId,
    String? relatedPersonId,
    RelationshipType? relationshipType,
    String? subType,
    bool? isCurrent,
    String? startDate,
    bool? startDateApprox,
    String? endDate,
    bool? endDateApprox,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RelationshipEntity(
      id: id ?? this.id,
      treeId: treeId ?? this.treeId,
      personId: personId ?? this.personId,
      relatedPersonId: relatedPersonId ?? this.relatedPersonId,
      relationshipType: relationshipType ?? this.relationshipType,
      subType: subType ?? this.subType,
      isCurrent: isCurrent ?? this.isCurrent,
      startDate: startDate ?? this.startDate,
      startDateApprox: startDateApprox ?? this.startDateApprox,
      endDate: endDate ?? this.endDate,
      endDateApprox: endDateApprox ?? this.endDateApprox,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // ── JSON ─────────────────────────────────────────────────────────────────

  Map<String, dynamic> toJson() => {
        'id': id,
        'tree_id': treeId,
        'person_id': personId,
        'related_person_id': relatedPersonId,
        'relationship_type': relationshipType.value,
        'sub_type': subType,
        'is_current': isCurrent,
        'start_date': startDate,
        'start_date_approx': startDateApprox,
        'end_date': endDate,
        'end_date_approx': endDateApprox,
        'notes': notes,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  factory RelationshipEntity.fromJson(Map<String, dynamic> json) =>
      RelationshipEntity(
        id: json['id'] as String,
        treeId: json['tree_id'] as String,
        personId: json['person_id'] as String,
        relatedPersonId: json['related_person_id'] as String,
        relationshipType:
            RelationshipType.fromValue(json['relationship_type'] as String),
        subType: json['sub_type'] as String?,
        isCurrent: json['is_current'] as bool? ?? true,
        startDate: json['start_date'] as String?,
        startDateApprox: json['start_date_approx'] as bool? ?? false,
        endDate: json['end_date'] as String?,
        endDateApprox: json['end_date_approx'] as bool? ?? false,
        notes: json['notes'] as String?,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RelationshipEntity && other.id == id);

  @override
  int get hashCode => id.hashCode;
}

// ─── SiblingEntry (derived, not stored) ──────────────────────────────────────

class SiblingEntry {
  final String personId;
  final SiblingType siblingType;
  final int sharedParentCount;

  const SiblingEntry({
    required this.personId,
    required this.siblingType,
    required this.sharedParentCount,
  });
}
