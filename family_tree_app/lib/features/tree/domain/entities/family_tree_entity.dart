// lib/features/tree/domain/entities/family_tree_entity.dart

class FamilyTreeEntity {
  final String id;
  final String name;
  final String? description;
  final String? rootPersonId;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Transient — populated on load
  final int memberCount;

  const FamilyTreeEntity({
    required this.id,
    required this.name,
    this.description,
    this.rootPersonId,
    required this.createdAt,
    required this.updatedAt,
    this.memberCount = 0,
  });

  FamilyTreeEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? rootPersonId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? memberCount,
  }) {
    return FamilyTreeEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      rootPersonId: rootPersonId ?? this.rootPersonId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      memberCount: memberCount ?? this.memberCount,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'root_person_id': rootPersonId,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  factory FamilyTreeEntity.fromJson(Map<String, dynamic> json) {
    return FamilyTreeEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      rootPersonId: json['root_person_id'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is FamilyTreeEntity && other.id == id);

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'FamilyTreeEntity(id: $id, name: $name)';
}
