// lib/features/member/domain/entities/person_entity.dart
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_util.dart';

class PersonEntity {
  final String id;
  final String treeId;

  // Name
  final String firstName;
  final String? middleName;
  final String? lastName;
  final String? maidenName;
  final String? nickname;

  // Demographics
  final Gender gender;
  final bool isLiving;

  // Dates
  final String? birthDate;
  final bool birthDateApprox;
  final String? deathDate;
  final bool deathDateApprox;

  // Places
  final String? birthPlace;
  final String? deathPlace;
  final String? currentLocation;

  // Personal
  final String? occupation;
  final String? biography;
  final String? nationality;
  final String? education;

  // Contact
  final String? email;
  final String? phone;
  final String? address;
  final String? website;

  // Media
  final String? profilePhotoPath;

  // Audit
  final DateTime createdAt;
  final DateTime updatedAt;

  const PersonEntity({
    required this.id,
    required this.treeId,
    required this.firstName,
    this.middleName,
    this.lastName,
    this.maidenName,
    this.nickname,
    this.gender = Gender.unknown,
    this.isLiving = true,
    this.birthDate,
    this.birthDateApprox = false,
    this.deathDate,
    this.deathDateApprox = false,
    this.birthPlace,
    this.deathPlace,
    this.currentLocation,
    this.occupation,
    this.biography,
    this.nationality,
    this.education,
    this.email,
    this.phone,
    this.address,
    this.website,
    this.profilePhotoPath,
    required this.createdAt,
    required this.updatedAt,
  });

  // ── Computed Properties ───────────────────────────────────────────────────

  String get fullName {
    final parts = [firstName, middleName, lastName]
        .where((s) => s != null && s.isNotEmpty)
        .toList();
    return parts.join(' ');
  }

  String get displayName => nickname != null && nickname!.isNotEmpty
      ? '"$nickname" $fullName'
      : fullName;

  String get shortName =>
      [firstName, lastName].where((s) => s != null && s.isNotEmpty).join(' ');

  String get initials {
    final f = firstName.isNotEmpty ? firstName[0] : '';
    final l = (lastName ?? '').isNotEmpty ? lastName![0] : '';
    return (f + l).toUpperCase();
  }

  String get lifespan =>
      DateUtil.lifespan(birthDate, deathDate, isLiving);

  int? get birthYear => DateUtil.extractYear(birthDate);
  int? get deathYear => DateUtil.extractYear(deathDate);

  int? get age => DateUtil.calculateAge(birthDate, isLiving ? null : deathDate);

  String get birthDateDisplay =>
      DateUtil.formatDisplay(birthDate, approx: birthDateApprox);
  String get deathDateDisplay =>
      DateUtil.formatDisplay(deathDate, approx: deathDateApprox);

  // ── copyWith ─────────────────────────────────────────────────────────────

  PersonEntity copyWith({
    String? id,
    String? treeId,
    String? firstName,
    String? middleName,
    String? lastName,
    String? maidenName,
    String? nickname,
    Gender? gender,
    bool? isLiving,
    String? birthDate,
    bool? birthDateApprox,
    String? deathDate,
    bool? deathDateApprox,
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
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PersonEntity(
      id: id ?? this.id,
      treeId: treeId ?? this.treeId,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      maidenName: maidenName ?? this.maidenName,
      nickname: nickname ?? this.nickname,
      gender: gender ?? this.gender,
      isLiving: isLiving ?? this.isLiving,
      birthDate: birthDate ?? this.birthDate,
      birthDateApprox: birthDateApprox ?? this.birthDateApprox,
      deathDate: deathDate ?? this.deathDate,
      deathDateApprox: deathDateApprox ?? this.deathDateApprox,
      birthPlace: birthPlace ?? this.birthPlace,
      deathPlace: deathPlace ?? this.deathPlace,
      currentLocation: currentLocation ?? this.currentLocation,
      occupation: occupation ?? this.occupation,
      biography: biography ?? this.biography,
      nationality: nationality ?? this.nationality,
      education: education ?? this.education,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      website: website ?? this.website,
      profilePhotoPath: profilePhotoPath ?? this.profilePhotoPath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // ── JSON ─────────────────────────────────────────────────────────────────

  Map<String, dynamic> toJson() => {
        'id': id,
        'tree_id': treeId,
        'first_name': firstName,
        'middle_name': middleName,
        'last_name': lastName,
        'maiden_name': maidenName,
        'nickname': nickname,
        'gender': gender.value,
        'is_living': isLiving,
        'birth_date': birthDate,
        'birth_date_approx': birthDateApprox,
        'death_date': deathDate,
        'death_date_approx': deathDateApprox,
        'birth_place': birthPlace,
        'death_place': deathPlace,
        'current_location': currentLocation,
        'occupation': occupation,
        'biography': biography,
        'nationality': nationality,
        'education': education,
        'email': email,
        'phone': phone,
        'address': address,
        'website': website,
        'profile_photo_path': profilePhotoPath,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  factory PersonEntity.fromJson(Map<String, dynamic> json) => PersonEntity(
        id: json['id'] as String,
        treeId: json['tree_id'] as String,
        firstName: json['first_name'] as String,
        middleName: json['middle_name'] as String?,
        lastName: json['last_name'] as String?,
        maidenName: json['maiden_name'] as String?,
        nickname: json['nickname'] as String?,
        gender: Gender.fromValue(json['gender'] as String? ?? 'UNKNOWN'),
        isLiving: json['is_living'] as bool? ?? true,
        birthDate: json['birth_date'] as String?,
        birthDateApprox: json['birth_date_approx'] as bool? ?? false,
        deathDate: json['death_date'] as String?,
        deathDateApprox: json['death_date_approx'] as bool? ?? false,
        birthPlace: json['birth_place'] as String?,
        deathPlace: json['death_place'] as String?,
        currentLocation: json['current_location'] as String?,
        occupation: json['occupation'] as String?,
        biography: json['biography'] as String?,
        nationality: json['nationality'] as String?,
        education: json['education'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        address: json['address'] as String?,
        website: json['website'] as String?,
        profilePhotoPath: json['profile_photo_path'] as String?,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is PersonEntity && other.id == id);

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'PersonEntity(id: $id, name: $fullName)';
}
