// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FamilyTreesTable extends FamilyTrees
    with TableInfo<$FamilyTreesTable, FamilyTreeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FamilyTreesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _rootPersonIdMeta =
      const VerificationMeta('rootPersonId');
  @override
  late final GeneratedColumn<String> rootPersonId = GeneratedColumn<String>(
      'root_person_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, rootPersonId, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'family_trees';
  @override
  VerificationContext validateIntegrity(Insertable<FamilyTreeData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('root_person_id')) {
      context.handle(
          _rootPersonIdMeta,
          rootPersonId.isAcceptableOrUnknown(
              data['root_person_id']!, _rootPersonIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FamilyTreeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FamilyTreeData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      rootPersonId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}root_person_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $FamilyTreesTable createAlias(String alias) {
    return $FamilyTreesTable(attachedDatabase, alias);
  }
}

class FamilyTreeData extends DataClass implements Insertable<FamilyTreeData> {
  final String id;
  final String name;
  final String? description;
  final String? rootPersonId;
  final String createdAt;
  final String updatedAt;
  const FamilyTreeData(
      {required this.id,
      required this.name,
      this.description,
      this.rootPersonId,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || rootPersonId != null) {
      map['root_person_id'] = Variable<String>(rootPersonId);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  FamilyTreesCompanion toCompanion(bool nullToAbsent) {
    return FamilyTreesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      rootPersonId: rootPersonId == null && nullToAbsent
          ? const Value.absent()
          : Value(rootPersonId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FamilyTreeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FamilyTreeData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      rootPersonId: serializer.fromJson<String?>(json['rootPersonId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'rootPersonId': serializer.toJson<String?>(rootPersonId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  FamilyTreeData copyWith(
          {String? id,
          String? name,
          Value<String?> description = const Value.absent(),
          Value<String?> rootPersonId = const Value.absent(),
          String? createdAt,
          String? updatedAt}) =>
      FamilyTreeData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        rootPersonId:
            rootPersonId.present ? rootPersonId.value : this.rootPersonId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  FamilyTreeData copyWithCompanion(FamilyTreesCompanion data) {
    return FamilyTreeData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      rootPersonId: data.rootPersonId.present
          ? data.rootPersonId.value
          : this.rootPersonId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FamilyTreeData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('rootPersonId: $rootPersonId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, rootPersonId, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FamilyTreeData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.rootPersonId == this.rootPersonId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FamilyTreesCompanion extends UpdateCompanion<FamilyTreeData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> rootPersonId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> rowid;
  const FamilyTreesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.rootPersonId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FamilyTreesCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.rootPersonId = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<FamilyTreeData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? rootPersonId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (rootPersonId != null) 'root_person_id': rootPersonId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FamilyTreesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<String?>? rootPersonId,
      Value<String>? createdAt,
      Value<String>? updatedAt,
      Value<int>? rowid}) {
    return FamilyTreesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      rootPersonId: rootPersonId ?? this.rootPersonId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rootPersonId.present) {
      map['root_person_id'] = Variable<String>(rootPersonId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FamilyTreesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('rootPersonId: $rootPersonId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PersonsTable extends Persons with TableInfo<$PersonsTable, PersonData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _treeIdMeta = const VerificationMeta('treeId');
  @override
  late final GeneratedColumn<String> treeId = GeneratedColumn<String>(
      'tree_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _middleNameMeta =
      const VerificationMeta('middleName');
  @override
  late final GeneratedColumn<String> middleName = GeneratedColumn<String>(
      'middle_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _maidenNameMeta =
      const VerificationMeta('maidenName');
  @override
  late final GeneratedColumn<String> maidenName = GeneratedColumn<String>(
      'maiden_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nicknameMeta =
      const VerificationMeta('nickname');
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
      'nickname', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('UNKNOWN'));
  static const VerificationMeta _isLivingMeta =
      const VerificationMeta('isLiving');
  @override
  late final GeneratedColumn<bool> isLiving = GeneratedColumn<bool>(
      'is_living', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_living" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _birthDateMeta =
      const VerificationMeta('birthDate');
  @override
  late final GeneratedColumn<String> birthDate = GeneratedColumn<String>(
      'birth_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _birthDateApproxMeta =
      const VerificationMeta('birthDateApprox');
  @override
  late final GeneratedColumn<bool> birthDateApprox = GeneratedColumn<bool>(
      'birth_date_approx', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("birth_date_approx" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _deathDateMeta =
      const VerificationMeta('deathDate');
  @override
  late final GeneratedColumn<String> deathDate = GeneratedColumn<String>(
      'death_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _deathDateApproxMeta =
      const VerificationMeta('deathDateApprox');
  @override
  late final GeneratedColumn<bool> deathDateApprox = GeneratedColumn<bool>(
      'death_date_approx', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("death_date_approx" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _birthPlaceMeta =
      const VerificationMeta('birthPlace');
  @override
  late final GeneratedColumn<String> birthPlace = GeneratedColumn<String>(
      'birth_place', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _deathPlaceMeta =
      const VerificationMeta('deathPlace');
  @override
  late final GeneratedColumn<String> deathPlace = GeneratedColumn<String>(
      'death_place', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _currentLocationMeta =
      const VerificationMeta('currentLocation');
  @override
  late final GeneratedColumn<String> currentLocation = GeneratedColumn<String>(
      'current_location', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _occupationMeta =
      const VerificationMeta('occupation');
  @override
  late final GeneratedColumn<String> occupation = GeneratedColumn<String>(
      'occupation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _biographyMeta =
      const VerificationMeta('biography');
  @override
  late final GeneratedColumn<String> biography = GeneratedColumn<String>(
      'biography', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nationalityMeta =
      const VerificationMeta('nationality');
  @override
  late final GeneratedColumn<String> nationality = GeneratedColumn<String>(
      'nationality', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _educationMeta =
      const VerificationMeta('education');
  @override
  late final GeneratedColumn<String> education = GeneratedColumn<String>(
      'education', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _websiteMeta =
      const VerificationMeta('website');
  @override
  late final GeneratedColumn<String> website = GeneratedColumn<String>(
      'website', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _profilePhotoPathMeta =
      const VerificationMeta('profilePhotoPath');
  @override
  late final GeneratedColumn<String> profilePhotoPath = GeneratedColumn<String>(
      'profile_photo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        treeId,
        firstName,
        middleName,
        lastName,
        maidenName,
        nickname,
        gender,
        isLiving,
        birthDate,
        birthDateApprox,
        deathDate,
        deathDateApprox,
        birthPlace,
        deathPlace,
        currentLocation,
        occupation,
        biography,
        nationality,
        education,
        email,
        phone,
        address,
        website,
        profilePhotoPath,
        isDeleted,
        deletedAt,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'persons';
  @override
  VerificationContext validateIntegrity(Insertable<PersonData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tree_id')) {
      context.handle(_treeIdMeta,
          treeId.isAcceptableOrUnknown(data['tree_id']!, _treeIdMeta));
    } else if (isInserting) {
      context.missing(_treeIdMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('middle_name')) {
      context.handle(
          _middleNameMeta,
          middleName.isAcceptableOrUnknown(
              data['middle_name']!, _middleNameMeta));
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    }
    if (data.containsKey('maiden_name')) {
      context.handle(
          _maidenNameMeta,
          maidenName.isAcceptableOrUnknown(
              data['maiden_name']!, _maidenNameMeta));
    }
    if (data.containsKey('nickname')) {
      context.handle(_nicknameMeta,
          nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('is_living')) {
      context.handle(_isLivingMeta,
          isLiving.isAcceptableOrUnknown(data['is_living']!, _isLivingMeta));
    }
    if (data.containsKey('birth_date')) {
      context.handle(_birthDateMeta,
          birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta));
    }
    if (data.containsKey('birth_date_approx')) {
      context.handle(
          _birthDateApproxMeta,
          birthDateApprox.isAcceptableOrUnknown(
              data['birth_date_approx']!, _birthDateApproxMeta));
    }
    if (data.containsKey('death_date')) {
      context.handle(_deathDateMeta,
          deathDate.isAcceptableOrUnknown(data['death_date']!, _deathDateMeta));
    }
    if (data.containsKey('death_date_approx')) {
      context.handle(
          _deathDateApproxMeta,
          deathDateApprox.isAcceptableOrUnknown(
              data['death_date_approx']!, _deathDateApproxMeta));
    }
    if (data.containsKey('birth_place')) {
      context.handle(
          _birthPlaceMeta,
          birthPlace.isAcceptableOrUnknown(
              data['birth_place']!, _birthPlaceMeta));
    }
    if (data.containsKey('death_place')) {
      context.handle(
          _deathPlaceMeta,
          deathPlace.isAcceptableOrUnknown(
              data['death_place']!, _deathPlaceMeta));
    }
    if (data.containsKey('current_location')) {
      context.handle(
          _currentLocationMeta,
          currentLocation.isAcceptableOrUnknown(
              data['current_location']!, _currentLocationMeta));
    }
    if (data.containsKey('occupation')) {
      context.handle(
          _occupationMeta,
          occupation.isAcceptableOrUnknown(
              data['occupation']!, _occupationMeta));
    }
    if (data.containsKey('biography')) {
      context.handle(_biographyMeta,
          biography.isAcceptableOrUnknown(data['biography']!, _biographyMeta));
    }
    if (data.containsKey('nationality')) {
      context.handle(
          _nationalityMeta,
          nationality.isAcceptableOrUnknown(
              data['nationality']!, _nationalityMeta));
    }
    if (data.containsKey('education')) {
      context.handle(_educationMeta,
          education.isAcceptableOrUnknown(data['education']!, _educationMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('website')) {
      context.handle(_websiteMeta,
          website.isAcceptableOrUnknown(data['website']!, _websiteMeta));
    }
    if (data.containsKey('profile_photo_path')) {
      context.handle(
          _profilePhotoPathMeta,
          profilePhotoPath.isAcceptableOrUnknown(
              data['profile_photo_path']!, _profilePhotoPathMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersonData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      treeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tree_id'])!,
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      middleName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}middle_name']),
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name']),
      maidenName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}maiden_name']),
      nickname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nickname']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!,
      isLiving: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_living'])!,
      birthDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}birth_date']),
      birthDateApprox: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}birth_date_approx'])!,
      deathDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}death_date']),
      deathDateApprox: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}death_date_approx'])!,
      birthPlace: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}birth_place']),
      deathPlace: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}death_place']),
      currentLocation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}current_location']),
      occupation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}occupation']),
      biography: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}biography']),
      nationality: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nationality']),
      education: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}education']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      website: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}website']),
      profilePhotoPath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}profile_photo_path']),
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}deleted_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PersonsTable createAlias(String alias) {
    return $PersonsTable(attachedDatabase, alias);
  }
}

class PersonData extends DataClass implements Insertable<PersonData> {
  final String id;
  final String treeId;
  final String firstName;
  final String? middleName;
  final String? lastName;
  final String? maidenName;
  final String? nickname;
  final String gender;
  final bool isLiving;
  final String? birthDate;
  final bool birthDateApprox;
  final String? deathDate;
  final bool deathDateApprox;
  final String? birthPlace;
  final String? deathPlace;
  final String? currentLocation;
  final String? occupation;
  final String? biography;
  final String? nationality;
  final String? education;
  final String? email;
  final String? phone;
  final String? address;
  final String? website;
  final String? profilePhotoPath;
  final bool isDeleted;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;
  const PersonData(
      {required this.id,
      required this.treeId,
      required this.firstName,
      this.middleName,
      this.lastName,
      this.maidenName,
      this.nickname,
      required this.gender,
      required this.isLiving,
      this.birthDate,
      required this.birthDateApprox,
      this.deathDate,
      required this.deathDateApprox,
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
      required this.isDeleted,
      this.deletedAt,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tree_id'] = Variable<String>(treeId);
    map['first_name'] = Variable<String>(firstName);
    if (!nullToAbsent || middleName != null) {
      map['middle_name'] = Variable<String>(middleName);
    }
    if (!nullToAbsent || lastName != null) {
      map['last_name'] = Variable<String>(lastName);
    }
    if (!nullToAbsent || maidenName != null) {
      map['maiden_name'] = Variable<String>(maidenName);
    }
    if (!nullToAbsent || nickname != null) {
      map['nickname'] = Variable<String>(nickname);
    }
    map['gender'] = Variable<String>(gender);
    map['is_living'] = Variable<bool>(isLiving);
    if (!nullToAbsent || birthDate != null) {
      map['birth_date'] = Variable<String>(birthDate);
    }
    map['birth_date_approx'] = Variable<bool>(birthDateApprox);
    if (!nullToAbsent || deathDate != null) {
      map['death_date'] = Variable<String>(deathDate);
    }
    map['death_date_approx'] = Variable<bool>(deathDateApprox);
    if (!nullToAbsent || birthPlace != null) {
      map['birth_place'] = Variable<String>(birthPlace);
    }
    if (!nullToAbsent || deathPlace != null) {
      map['death_place'] = Variable<String>(deathPlace);
    }
    if (!nullToAbsent || currentLocation != null) {
      map['current_location'] = Variable<String>(currentLocation);
    }
    if (!nullToAbsent || occupation != null) {
      map['occupation'] = Variable<String>(occupation);
    }
    if (!nullToAbsent || biography != null) {
      map['biography'] = Variable<String>(biography);
    }
    if (!nullToAbsent || nationality != null) {
      map['nationality'] = Variable<String>(nationality);
    }
    if (!nullToAbsent || education != null) {
      map['education'] = Variable<String>(education);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || website != null) {
      map['website'] = Variable<String>(website);
    }
    if (!nullToAbsent || profilePhotoPath != null) {
      map['profile_photo_path'] = Variable<String>(profilePhotoPath);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  PersonsCompanion toCompanion(bool nullToAbsent) {
    return PersonsCompanion(
      id: Value(id),
      treeId: Value(treeId),
      firstName: Value(firstName),
      middleName: middleName == null && nullToAbsent
          ? const Value.absent()
          : Value(middleName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
      maidenName: maidenName == null && nullToAbsent
          ? const Value.absent()
          : Value(maidenName),
      nickname: nickname == null && nullToAbsent
          ? const Value.absent()
          : Value(nickname),
      gender: Value(gender),
      isLiving: Value(isLiving),
      birthDate: birthDate == null && nullToAbsent
          ? const Value.absent()
          : Value(birthDate),
      birthDateApprox: Value(birthDateApprox),
      deathDate: deathDate == null && nullToAbsent
          ? const Value.absent()
          : Value(deathDate),
      deathDateApprox: Value(deathDateApprox),
      birthPlace: birthPlace == null && nullToAbsent
          ? const Value.absent()
          : Value(birthPlace),
      deathPlace: deathPlace == null && nullToAbsent
          ? const Value.absent()
          : Value(deathPlace),
      currentLocation: currentLocation == null && nullToAbsent
          ? const Value.absent()
          : Value(currentLocation),
      occupation: occupation == null && nullToAbsent
          ? const Value.absent()
          : Value(occupation),
      biography: biography == null && nullToAbsent
          ? const Value.absent()
          : Value(biography),
      nationality: nationality == null && nullToAbsent
          ? const Value.absent()
          : Value(nationality),
      education: education == null && nullToAbsent
          ? const Value.absent()
          : Value(education),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      website: website == null && nullToAbsent
          ? const Value.absent()
          : Value(website),
      profilePhotoPath: profilePhotoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(profilePhotoPath),
      isDeleted: Value(isDeleted),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PersonData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonData(
      id: serializer.fromJson<String>(json['id']),
      treeId: serializer.fromJson<String>(json['treeId']),
      firstName: serializer.fromJson<String>(json['firstName']),
      middleName: serializer.fromJson<String?>(json['middleName']),
      lastName: serializer.fromJson<String?>(json['lastName']),
      maidenName: serializer.fromJson<String?>(json['maidenName']),
      nickname: serializer.fromJson<String?>(json['nickname']),
      gender: serializer.fromJson<String>(json['gender']),
      isLiving: serializer.fromJson<bool>(json['isLiving']),
      birthDate: serializer.fromJson<String?>(json['birthDate']),
      birthDateApprox: serializer.fromJson<bool>(json['birthDateApprox']),
      deathDate: serializer.fromJson<String?>(json['deathDate']),
      deathDateApprox: serializer.fromJson<bool>(json['deathDateApprox']),
      birthPlace: serializer.fromJson<String?>(json['birthPlace']),
      deathPlace: serializer.fromJson<String?>(json['deathPlace']),
      currentLocation: serializer.fromJson<String?>(json['currentLocation']),
      occupation: serializer.fromJson<String?>(json['occupation']),
      biography: serializer.fromJson<String?>(json['biography']),
      nationality: serializer.fromJson<String?>(json['nationality']),
      education: serializer.fromJson<String?>(json['education']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      website: serializer.fromJson<String?>(json['website']),
      profilePhotoPath: serializer.fromJson<String?>(json['profilePhotoPath']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'treeId': serializer.toJson<String>(treeId),
      'firstName': serializer.toJson<String>(firstName),
      'middleName': serializer.toJson<String?>(middleName),
      'lastName': serializer.toJson<String?>(lastName),
      'maidenName': serializer.toJson<String?>(maidenName),
      'nickname': serializer.toJson<String?>(nickname),
      'gender': serializer.toJson<String>(gender),
      'isLiving': serializer.toJson<bool>(isLiving),
      'birthDate': serializer.toJson<String?>(birthDate),
      'birthDateApprox': serializer.toJson<bool>(birthDateApprox),
      'deathDate': serializer.toJson<String?>(deathDate),
      'deathDateApprox': serializer.toJson<bool>(deathDateApprox),
      'birthPlace': serializer.toJson<String?>(birthPlace),
      'deathPlace': serializer.toJson<String?>(deathPlace),
      'currentLocation': serializer.toJson<String?>(currentLocation),
      'occupation': serializer.toJson<String?>(occupation),
      'biography': serializer.toJson<String?>(biography),
      'nationality': serializer.toJson<String?>(nationality),
      'education': serializer.toJson<String?>(education),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'website': serializer.toJson<String?>(website),
      'profilePhotoPath': serializer.toJson<String?>(profilePhotoPath),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  PersonData copyWith(
          {String? id,
          String? treeId,
          String? firstName,
          Value<String?> middleName = const Value.absent(),
          Value<String?> lastName = const Value.absent(),
          Value<String?> maidenName = const Value.absent(),
          Value<String?> nickname = const Value.absent(),
          String? gender,
          bool? isLiving,
          Value<String?> birthDate = const Value.absent(),
          bool? birthDateApprox,
          Value<String?> deathDate = const Value.absent(),
          bool? deathDateApprox,
          Value<String?> birthPlace = const Value.absent(),
          Value<String?> deathPlace = const Value.absent(),
          Value<String?> currentLocation = const Value.absent(),
          Value<String?> occupation = const Value.absent(),
          Value<String?> biography = const Value.absent(),
          Value<String?> nationality = const Value.absent(),
          Value<String?> education = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> address = const Value.absent(),
          Value<String?> website = const Value.absent(),
          Value<String?> profilePhotoPath = const Value.absent(),
          bool? isDeleted,
          Value<String?> deletedAt = const Value.absent(),
          String? createdAt,
          String? updatedAt}) =>
      PersonData(
        id: id ?? this.id,
        treeId: treeId ?? this.treeId,
        firstName: firstName ?? this.firstName,
        middleName: middleName.present ? middleName.value : this.middleName,
        lastName: lastName.present ? lastName.value : this.lastName,
        maidenName: maidenName.present ? maidenName.value : this.maidenName,
        nickname: nickname.present ? nickname.value : this.nickname,
        gender: gender ?? this.gender,
        isLiving: isLiving ?? this.isLiving,
        birthDate: birthDate.present ? birthDate.value : this.birthDate,
        birthDateApprox: birthDateApprox ?? this.birthDateApprox,
        deathDate: deathDate.present ? deathDate.value : this.deathDate,
        deathDateApprox: deathDateApprox ?? this.deathDateApprox,
        birthPlace: birthPlace.present ? birthPlace.value : this.birthPlace,
        deathPlace: deathPlace.present ? deathPlace.value : this.deathPlace,
        currentLocation: currentLocation.present
            ? currentLocation.value
            : this.currentLocation,
        occupation: occupation.present ? occupation.value : this.occupation,
        biography: biography.present ? biography.value : this.biography,
        nationality: nationality.present ? nationality.value : this.nationality,
        education: education.present ? education.value : this.education,
        email: email.present ? email.value : this.email,
        phone: phone.present ? phone.value : this.phone,
        address: address.present ? address.value : this.address,
        website: website.present ? website.value : this.website,
        profilePhotoPath: profilePhotoPath.present
            ? profilePhotoPath.value
            : this.profilePhotoPath,
        isDeleted: isDeleted ?? this.isDeleted,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  PersonData copyWithCompanion(PersonsCompanion data) {
    return PersonData(
      id: data.id.present ? data.id.value : this.id,
      treeId: data.treeId.present ? data.treeId.value : this.treeId,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      middleName:
          data.middleName.present ? data.middleName.value : this.middleName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      maidenName:
          data.maidenName.present ? data.maidenName.value : this.maidenName,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      gender: data.gender.present ? data.gender.value : this.gender,
      isLiving: data.isLiving.present ? data.isLiving.value : this.isLiving,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      birthDateApprox: data.birthDateApprox.present
          ? data.birthDateApprox.value
          : this.birthDateApprox,
      deathDate: data.deathDate.present ? data.deathDate.value : this.deathDate,
      deathDateApprox: data.deathDateApprox.present
          ? data.deathDateApprox.value
          : this.deathDateApprox,
      birthPlace:
          data.birthPlace.present ? data.birthPlace.value : this.birthPlace,
      deathPlace:
          data.deathPlace.present ? data.deathPlace.value : this.deathPlace,
      currentLocation: data.currentLocation.present
          ? data.currentLocation.value
          : this.currentLocation,
      occupation:
          data.occupation.present ? data.occupation.value : this.occupation,
      biography: data.biography.present ? data.biography.value : this.biography,
      nationality:
          data.nationality.present ? data.nationality.value : this.nationality,
      education: data.education.present ? data.education.value : this.education,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      website: data.website.present ? data.website.value : this.website,
      profilePhotoPath: data.profilePhotoPath.present
          ? data.profilePhotoPath.value
          : this.profilePhotoPath,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonData(')
          ..write('id: $id, ')
          ..write('treeId: $treeId, ')
          ..write('firstName: $firstName, ')
          ..write('middleName: $middleName, ')
          ..write('lastName: $lastName, ')
          ..write('maidenName: $maidenName, ')
          ..write('nickname: $nickname, ')
          ..write('gender: $gender, ')
          ..write('isLiving: $isLiving, ')
          ..write('birthDate: $birthDate, ')
          ..write('birthDateApprox: $birthDateApprox, ')
          ..write('deathDate: $deathDate, ')
          ..write('deathDateApprox: $deathDateApprox, ')
          ..write('birthPlace: $birthPlace, ')
          ..write('deathPlace: $deathPlace, ')
          ..write('currentLocation: $currentLocation, ')
          ..write('occupation: $occupation, ')
          ..write('biography: $biography, ')
          ..write('nationality: $nationality, ')
          ..write('education: $education, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('website: $website, ')
          ..write('profilePhotoPath: $profilePhotoPath, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        treeId,
        firstName,
        middleName,
        lastName,
        maidenName,
        nickname,
        gender,
        isLiving,
        birthDate,
        birthDateApprox,
        deathDate,
        deathDateApprox,
        birthPlace,
        deathPlace,
        currentLocation,
        occupation,
        biography,
        nationality,
        education,
        email,
        phone,
        address,
        website,
        profilePhotoPath,
        isDeleted,
        deletedAt,
        createdAt,
        updatedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonData &&
          other.id == this.id &&
          other.treeId == this.treeId &&
          other.firstName == this.firstName &&
          other.middleName == this.middleName &&
          other.lastName == this.lastName &&
          other.maidenName == this.maidenName &&
          other.nickname == this.nickname &&
          other.gender == this.gender &&
          other.isLiving == this.isLiving &&
          other.birthDate == this.birthDate &&
          other.birthDateApprox == this.birthDateApprox &&
          other.deathDate == this.deathDate &&
          other.deathDateApprox == this.deathDateApprox &&
          other.birthPlace == this.birthPlace &&
          other.deathPlace == this.deathPlace &&
          other.currentLocation == this.currentLocation &&
          other.occupation == this.occupation &&
          other.biography == this.biography &&
          other.nationality == this.nationality &&
          other.education == this.education &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.website == this.website &&
          other.profilePhotoPath == this.profilePhotoPath &&
          other.isDeleted == this.isDeleted &&
          other.deletedAt == this.deletedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PersonsCompanion extends UpdateCompanion<PersonData> {
  final Value<String> id;
  final Value<String> treeId;
  final Value<String> firstName;
  final Value<String?> middleName;
  final Value<String?> lastName;
  final Value<String?> maidenName;
  final Value<String?> nickname;
  final Value<String> gender;
  final Value<bool> isLiving;
  final Value<String?> birthDate;
  final Value<bool> birthDateApprox;
  final Value<String?> deathDate;
  final Value<bool> deathDateApprox;
  final Value<String?> birthPlace;
  final Value<String?> deathPlace;
  final Value<String?> currentLocation;
  final Value<String?> occupation;
  final Value<String?> biography;
  final Value<String?> nationality;
  final Value<String?> education;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<String?> website;
  final Value<String?> profilePhotoPath;
  final Value<bool> isDeleted;
  final Value<String?> deletedAt;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> rowid;
  const PersonsCompanion({
    this.id = const Value.absent(),
    this.treeId = const Value.absent(),
    this.firstName = const Value.absent(),
    this.middleName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.maidenName = const Value.absent(),
    this.nickname = const Value.absent(),
    this.gender = const Value.absent(),
    this.isLiving = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.birthDateApprox = const Value.absent(),
    this.deathDate = const Value.absent(),
    this.deathDateApprox = const Value.absent(),
    this.birthPlace = const Value.absent(),
    this.deathPlace = const Value.absent(),
    this.currentLocation = const Value.absent(),
    this.occupation = const Value.absent(),
    this.biography = const Value.absent(),
    this.nationality = const Value.absent(),
    this.education = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.website = const Value.absent(),
    this.profilePhotoPath = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PersonsCompanion.insert({
    required String id,
    required String treeId,
    required String firstName,
    this.middleName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.maidenName = const Value.absent(),
    this.nickname = const Value.absent(),
    this.gender = const Value.absent(),
    this.isLiving = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.birthDateApprox = const Value.absent(),
    this.deathDate = const Value.absent(),
    this.deathDateApprox = const Value.absent(),
    this.birthPlace = const Value.absent(),
    this.deathPlace = const Value.absent(),
    this.currentLocation = const Value.absent(),
    this.occupation = const Value.absent(),
    this.biography = const Value.absent(),
    this.nationality = const Value.absent(),
    this.education = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.website = const Value.absent(),
    this.profilePhotoPath = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        treeId = Value(treeId),
        firstName = Value(firstName),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<PersonData> custom({
    Expression<String>? id,
    Expression<String>? treeId,
    Expression<String>? firstName,
    Expression<String>? middleName,
    Expression<String>? lastName,
    Expression<String>? maidenName,
    Expression<String>? nickname,
    Expression<String>? gender,
    Expression<bool>? isLiving,
    Expression<String>? birthDate,
    Expression<bool>? birthDateApprox,
    Expression<String>? deathDate,
    Expression<bool>? deathDateApprox,
    Expression<String>? birthPlace,
    Expression<String>? deathPlace,
    Expression<String>? currentLocation,
    Expression<String>? occupation,
    Expression<String>? biography,
    Expression<String>? nationality,
    Expression<String>? education,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<String>? website,
    Expression<String>? profilePhotoPath,
    Expression<bool>? isDeleted,
    Expression<String>? deletedAt,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (treeId != null) 'tree_id': treeId,
      if (firstName != null) 'first_name': firstName,
      if (middleName != null) 'middle_name': middleName,
      if (lastName != null) 'last_name': lastName,
      if (maidenName != null) 'maiden_name': maidenName,
      if (nickname != null) 'nickname': nickname,
      if (gender != null) 'gender': gender,
      if (isLiving != null) 'is_living': isLiving,
      if (birthDate != null) 'birth_date': birthDate,
      if (birthDateApprox != null) 'birth_date_approx': birthDateApprox,
      if (deathDate != null) 'death_date': deathDate,
      if (deathDateApprox != null) 'death_date_approx': deathDateApprox,
      if (birthPlace != null) 'birth_place': birthPlace,
      if (deathPlace != null) 'death_place': deathPlace,
      if (currentLocation != null) 'current_location': currentLocation,
      if (occupation != null) 'occupation': occupation,
      if (biography != null) 'biography': biography,
      if (nationality != null) 'nationality': nationality,
      if (education != null) 'education': education,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (website != null) 'website': website,
      if (profilePhotoPath != null) 'profile_photo_path': profilePhotoPath,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PersonsCompanion copyWith(
      {Value<String>? id,
      Value<String>? treeId,
      Value<String>? firstName,
      Value<String?>? middleName,
      Value<String?>? lastName,
      Value<String?>? maidenName,
      Value<String?>? nickname,
      Value<String>? gender,
      Value<bool>? isLiving,
      Value<String?>? birthDate,
      Value<bool>? birthDateApprox,
      Value<String?>? deathDate,
      Value<bool>? deathDateApprox,
      Value<String?>? birthPlace,
      Value<String?>? deathPlace,
      Value<String?>? currentLocation,
      Value<String?>? occupation,
      Value<String?>? biography,
      Value<String?>? nationality,
      Value<String?>? education,
      Value<String?>? email,
      Value<String?>? phone,
      Value<String?>? address,
      Value<String?>? website,
      Value<String?>? profilePhotoPath,
      Value<bool>? isDeleted,
      Value<String?>? deletedAt,
      Value<String>? createdAt,
      Value<String>? updatedAt,
      Value<int>? rowid}) {
    return PersonsCompanion(
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
      isDeleted: isDeleted ?? this.isDeleted,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (treeId.present) {
      map['tree_id'] = Variable<String>(treeId.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (middleName.present) {
      map['middle_name'] = Variable<String>(middleName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (maidenName.present) {
      map['maiden_name'] = Variable<String>(maidenName.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (isLiving.present) {
      map['is_living'] = Variable<bool>(isLiving.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<String>(birthDate.value);
    }
    if (birthDateApprox.present) {
      map['birth_date_approx'] = Variable<bool>(birthDateApprox.value);
    }
    if (deathDate.present) {
      map['death_date'] = Variable<String>(deathDate.value);
    }
    if (deathDateApprox.present) {
      map['death_date_approx'] = Variable<bool>(deathDateApprox.value);
    }
    if (birthPlace.present) {
      map['birth_place'] = Variable<String>(birthPlace.value);
    }
    if (deathPlace.present) {
      map['death_place'] = Variable<String>(deathPlace.value);
    }
    if (currentLocation.present) {
      map['current_location'] = Variable<String>(currentLocation.value);
    }
    if (occupation.present) {
      map['occupation'] = Variable<String>(occupation.value);
    }
    if (biography.present) {
      map['biography'] = Variable<String>(biography.value);
    }
    if (nationality.present) {
      map['nationality'] = Variable<String>(nationality.value);
    }
    if (education.present) {
      map['education'] = Variable<String>(education.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (website.present) {
      map['website'] = Variable<String>(website.value);
    }
    if (profilePhotoPath.present) {
      map['profile_photo_path'] = Variable<String>(profilePhotoPath.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonsCompanion(')
          ..write('id: $id, ')
          ..write('treeId: $treeId, ')
          ..write('firstName: $firstName, ')
          ..write('middleName: $middleName, ')
          ..write('lastName: $lastName, ')
          ..write('maidenName: $maidenName, ')
          ..write('nickname: $nickname, ')
          ..write('gender: $gender, ')
          ..write('isLiving: $isLiving, ')
          ..write('birthDate: $birthDate, ')
          ..write('birthDateApprox: $birthDateApprox, ')
          ..write('deathDate: $deathDate, ')
          ..write('deathDateApprox: $deathDateApprox, ')
          ..write('birthPlace: $birthPlace, ')
          ..write('deathPlace: $deathPlace, ')
          ..write('currentLocation: $currentLocation, ')
          ..write('occupation: $occupation, ')
          ..write('biography: $biography, ')
          ..write('nationality: $nationality, ')
          ..write('education: $education, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('website: $website, ')
          ..write('profilePhotoPath: $profilePhotoPath, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RelationshipsTable extends Relationships
    with TableInfo<$RelationshipsTable, RelationshipData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RelationshipsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _treeIdMeta = const VerificationMeta('treeId');
  @override
  late final GeneratedColumn<String> treeId = GeneratedColumn<String>(
      'tree_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _personIdMeta =
      const VerificationMeta('personId');
  @override
  late final GeneratedColumn<String> personId = GeneratedColumn<String>(
      'person_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _relatedPersonIdMeta =
      const VerificationMeta('relatedPersonId');
  @override
  late final GeneratedColumn<String> relatedPersonId = GeneratedColumn<String>(
      'related_person_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _relationshipTypeMeta =
      const VerificationMeta('relationshipType');
  @override
  late final GeneratedColumn<String> relationshipType = GeneratedColumn<String>(
      'relationship_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subTypeMeta =
      const VerificationMeta('subType');
  @override
  late final GeneratedColumn<String> subType = GeneratedColumn<String>(
      'sub_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isCurrentMeta =
      const VerificationMeta('isCurrent');
  @override
  late final GeneratedColumn<bool> isCurrent = GeneratedColumn<bool>(
      'is_current', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_current" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
      'start_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startDateApproxMeta =
      const VerificationMeta('startDateApprox');
  @override
  late final GeneratedColumn<bool> startDateApprox = GeneratedColumn<bool>(
      'start_date_approx', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("start_date_approx" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<String> endDate = GeneratedColumn<String>(
      'end_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _endDateApproxMeta =
      const VerificationMeta('endDateApprox');
  @override
  late final GeneratedColumn<bool> endDateApprox = GeneratedColumn<bool>(
      'end_date_approx', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("end_date_approx" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        treeId,
        personId,
        relatedPersonId,
        relationshipType,
        subType,
        isCurrent,
        startDate,
        startDateApprox,
        endDate,
        endDateApprox,
        notes,
        isDeleted,
        deletedAt,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'relationships';
  @override
  VerificationContext validateIntegrity(Insertable<RelationshipData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tree_id')) {
      context.handle(_treeIdMeta,
          treeId.isAcceptableOrUnknown(data['tree_id']!, _treeIdMeta));
    } else if (isInserting) {
      context.missing(_treeIdMeta);
    }
    if (data.containsKey('person_id')) {
      context.handle(_personIdMeta,
          personId.isAcceptableOrUnknown(data['person_id']!, _personIdMeta));
    } else if (isInserting) {
      context.missing(_personIdMeta);
    }
    if (data.containsKey('related_person_id')) {
      context.handle(
          _relatedPersonIdMeta,
          relatedPersonId.isAcceptableOrUnknown(
              data['related_person_id']!, _relatedPersonIdMeta));
    } else if (isInserting) {
      context.missing(_relatedPersonIdMeta);
    }
    if (data.containsKey('relationship_type')) {
      context.handle(
          _relationshipTypeMeta,
          relationshipType.isAcceptableOrUnknown(
              data['relationship_type']!, _relationshipTypeMeta));
    } else if (isInserting) {
      context.missing(_relationshipTypeMeta);
    }
    if (data.containsKey('sub_type')) {
      context.handle(_subTypeMeta,
          subType.isAcceptableOrUnknown(data['sub_type']!, _subTypeMeta));
    }
    if (data.containsKey('is_current')) {
      context.handle(_isCurrentMeta,
          isCurrent.isAcceptableOrUnknown(data['is_current']!, _isCurrentMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('start_date_approx')) {
      context.handle(
          _startDateApproxMeta,
          startDateApprox.isAcceptableOrUnknown(
              data['start_date_approx']!, _startDateApproxMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('end_date_approx')) {
      context.handle(
          _endDateApproxMeta,
          endDateApprox.isAcceptableOrUnknown(
              data['end_date_approx']!, _endDateApproxMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RelationshipData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RelationshipData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      treeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tree_id'])!,
      personId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}person_id'])!,
      relatedPersonId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}related_person_id'])!,
      relationshipType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}relationship_type'])!,
      subType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sub_type']),
      isCurrent: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_current'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_date']),
      startDateApprox: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}start_date_approx'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_date']),
      endDateApprox: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}end_date_approx'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}deleted_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $RelationshipsTable createAlias(String alias) {
    return $RelationshipsTable(attachedDatabase, alias);
  }
}

class RelationshipData extends DataClass
    implements Insertable<RelationshipData> {
  final String id;
  final String treeId;
  final String personId;
  final String relatedPersonId;
  final String relationshipType;
  final String? subType;
  final bool isCurrent;
  final String? startDate;
  final bool startDateApprox;
  final String? endDate;
  final bool endDateApprox;
  final String? notes;
  final bool isDeleted;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;
  const RelationshipData(
      {required this.id,
      required this.treeId,
      required this.personId,
      required this.relatedPersonId,
      required this.relationshipType,
      this.subType,
      required this.isCurrent,
      this.startDate,
      required this.startDateApprox,
      this.endDate,
      required this.endDateApprox,
      this.notes,
      required this.isDeleted,
      this.deletedAt,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tree_id'] = Variable<String>(treeId);
    map['person_id'] = Variable<String>(personId);
    map['related_person_id'] = Variable<String>(relatedPersonId);
    map['relationship_type'] = Variable<String>(relationshipType);
    if (!nullToAbsent || subType != null) {
      map['sub_type'] = Variable<String>(subType);
    }
    map['is_current'] = Variable<bool>(isCurrent);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<String>(startDate);
    }
    map['start_date_approx'] = Variable<bool>(startDateApprox);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<String>(endDate);
    }
    map['end_date_approx'] = Variable<bool>(endDateApprox);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  RelationshipsCompanion toCompanion(bool nullToAbsent) {
    return RelationshipsCompanion(
      id: Value(id),
      treeId: Value(treeId),
      personId: Value(personId),
      relatedPersonId: Value(relatedPersonId),
      relationshipType: Value(relationshipType),
      subType: subType == null && nullToAbsent
          ? const Value.absent()
          : Value(subType),
      isCurrent: Value(isCurrent),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      startDateApprox: Value(startDateApprox),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      endDateApprox: Value(endDateApprox),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      isDeleted: Value(isDeleted),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RelationshipData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RelationshipData(
      id: serializer.fromJson<String>(json['id']),
      treeId: serializer.fromJson<String>(json['treeId']),
      personId: serializer.fromJson<String>(json['personId']),
      relatedPersonId: serializer.fromJson<String>(json['relatedPersonId']),
      relationshipType: serializer.fromJson<String>(json['relationshipType']),
      subType: serializer.fromJson<String?>(json['subType']),
      isCurrent: serializer.fromJson<bool>(json['isCurrent']),
      startDate: serializer.fromJson<String?>(json['startDate']),
      startDateApprox: serializer.fromJson<bool>(json['startDateApprox']),
      endDate: serializer.fromJson<String?>(json['endDate']),
      endDateApprox: serializer.fromJson<bool>(json['endDateApprox']),
      notes: serializer.fromJson<String?>(json['notes']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'treeId': serializer.toJson<String>(treeId),
      'personId': serializer.toJson<String>(personId),
      'relatedPersonId': serializer.toJson<String>(relatedPersonId),
      'relationshipType': serializer.toJson<String>(relationshipType),
      'subType': serializer.toJson<String?>(subType),
      'isCurrent': serializer.toJson<bool>(isCurrent),
      'startDate': serializer.toJson<String?>(startDate),
      'startDateApprox': serializer.toJson<bool>(startDateApprox),
      'endDate': serializer.toJson<String?>(endDate),
      'endDateApprox': serializer.toJson<bool>(endDateApprox),
      'notes': serializer.toJson<String?>(notes),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  RelationshipData copyWith(
          {String? id,
          String? treeId,
          String? personId,
          String? relatedPersonId,
          String? relationshipType,
          Value<String?> subType = const Value.absent(),
          bool? isCurrent,
          Value<String?> startDate = const Value.absent(),
          bool? startDateApprox,
          Value<String?> endDate = const Value.absent(),
          bool? endDateApprox,
          Value<String?> notes = const Value.absent(),
          bool? isDeleted,
          Value<String?> deletedAt = const Value.absent(),
          String? createdAt,
          String? updatedAt}) =>
      RelationshipData(
        id: id ?? this.id,
        treeId: treeId ?? this.treeId,
        personId: personId ?? this.personId,
        relatedPersonId: relatedPersonId ?? this.relatedPersonId,
        relationshipType: relationshipType ?? this.relationshipType,
        subType: subType.present ? subType.value : this.subType,
        isCurrent: isCurrent ?? this.isCurrent,
        startDate: startDate.present ? startDate.value : this.startDate,
        startDateApprox: startDateApprox ?? this.startDateApprox,
        endDate: endDate.present ? endDate.value : this.endDate,
        endDateApprox: endDateApprox ?? this.endDateApprox,
        notes: notes.present ? notes.value : this.notes,
        isDeleted: isDeleted ?? this.isDeleted,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  RelationshipData copyWithCompanion(RelationshipsCompanion data) {
    return RelationshipData(
      id: data.id.present ? data.id.value : this.id,
      treeId: data.treeId.present ? data.treeId.value : this.treeId,
      personId: data.personId.present ? data.personId.value : this.personId,
      relatedPersonId: data.relatedPersonId.present
          ? data.relatedPersonId.value
          : this.relatedPersonId,
      relationshipType: data.relationshipType.present
          ? data.relationshipType.value
          : this.relationshipType,
      subType: data.subType.present ? data.subType.value : this.subType,
      isCurrent: data.isCurrent.present ? data.isCurrent.value : this.isCurrent,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      startDateApprox: data.startDateApprox.present
          ? data.startDateApprox.value
          : this.startDateApprox,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      endDateApprox: data.endDateApprox.present
          ? data.endDateApprox.value
          : this.endDateApprox,
      notes: data.notes.present ? data.notes.value : this.notes,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RelationshipData(')
          ..write('id: $id, ')
          ..write('treeId: $treeId, ')
          ..write('personId: $personId, ')
          ..write('relatedPersonId: $relatedPersonId, ')
          ..write('relationshipType: $relationshipType, ')
          ..write('subType: $subType, ')
          ..write('isCurrent: $isCurrent, ')
          ..write('startDate: $startDate, ')
          ..write('startDateApprox: $startDateApprox, ')
          ..write('endDate: $endDate, ')
          ..write('endDateApprox: $endDateApprox, ')
          ..write('notes: $notes, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      treeId,
      personId,
      relatedPersonId,
      relationshipType,
      subType,
      isCurrent,
      startDate,
      startDateApprox,
      endDate,
      endDateApprox,
      notes,
      isDeleted,
      deletedAt,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RelationshipData &&
          other.id == this.id &&
          other.treeId == this.treeId &&
          other.personId == this.personId &&
          other.relatedPersonId == this.relatedPersonId &&
          other.relationshipType == this.relationshipType &&
          other.subType == this.subType &&
          other.isCurrent == this.isCurrent &&
          other.startDate == this.startDate &&
          other.startDateApprox == this.startDateApprox &&
          other.endDate == this.endDate &&
          other.endDateApprox == this.endDateApprox &&
          other.notes == this.notes &&
          other.isDeleted == this.isDeleted &&
          other.deletedAt == this.deletedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RelationshipsCompanion extends UpdateCompanion<RelationshipData> {
  final Value<String> id;
  final Value<String> treeId;
  final Value<String> personId;
  final Value<String> relatedPersonId;
  final Value<String> relationshipType;
  final Value<String?> subType;
  final Value<bool> isCurrent;
  final Value<String?> startDate;
  final Value<bool> startDateApprox;
  final Value<String?> endDate;
  final Value<bool> endDateApprox;
  final Value<String?> notes;
  final Value<bool> isDeleted;
  final Value<String?> deletedAt;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> rowid;
  const RelationshipsCompanion({
    this.id = const Value.absent(),
    this.treeId = const Value.absent(),
    this.personId = const Value.absent(),
    this.relatedPersonId = const Value.absent(),
    this.relationshipType = const Value.absent(),
    this.subType = const Value.absent(),
    this.isCurrent = const Value.absent(),
    this.startDate = const Value.absent(),
    this.startDateApprox = const Value.absent(),
    this.endDate = const Value.absent(),
    this.endDateApprox = const Value.absent(),
    this.notes = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RelationshipsCompanion.insert({
    required String id,
    required String treeId,
    required String personId,
    required String relatedPersonId,
    required String relationshipType,
    this.subType = const Value.absent(),
    this.isCurrent = const Value.absent(),
    this.startDate = const Value.absent(),
    this.startDateApprox = const Value.absent(),
    this.endDate = const Value.absent(),
    this.endDateApprox = const Value.absent(),
    this.notes = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        treeId = Value(treeId),
        personId = Value(personId),
        relatedPersonId = Value(relatedPersonId),
        relationshipType = Value(relationshipType),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<RelationshipData> custom({
    Expression<String>? id,
    Expression<String>? treeId,
    Expression<String>? personId,
    Expression<String>? relatedPersonId,
    Expression<String>? relationshipType,
    Expression<String>? subType,
    Expression<bool>? isCurrent,
    Expression<String>? startDate,
    Expression<bool>? startDateApprox,
    Expression<String>? endDate,
    Expression<bool>? endDateApprox,
    Expression<String>? notes,
    Expression<bool>? isDeleted,
    Expression<String>? deletedAt,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (treeId != null) 'tree_id': treeId,
      if (personId != null) 'person_id': personId,
      if (relatedPersonId != null) 'related_person_id': relatedPersonId,
      if (relationshipType != null) 'relationship_type': relationshipType,
      if (subType != null) 'sub_type': subType,
      if (isCurrent != null) 'is_current': isCurrent,
      if (startDate != null) 'start_date': startDate,
      if (startDateApprox != null) 'start_date_approx': startDateApprox,
      if (endDate != null) 'end_date': endDate,
      if (endDateApprox != null) 'end_date_approx': endDateApprox,
      if (notes != null) 'notes': notes,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RelationshipsCompanion copyWith(
      {Value<String>? id,
      Value<String>? treeId,
      Value<String>? personId,
      Value<String>? relatedPersonId,
      Value<String>? relationshipType,
      Value<String?>? subType,
      Value<bool>? isCurrent,
      Value<String?>? startDate,
      Value<bool>? startDateApprox,
      Value<String?>? endDate,
      Value<bool>? endDateApprox,
      Value<String?>? notes,
      Value<bool>? isDeleted,
      Value<String?>? deletedAt,
      Value<String>? createdAt,
      Value<String>? updatedAt,
      Value<int>? rowid}) {
    return RelationshipsCompanion(
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
      isDeleted: isDeleted ?? this.isDeleted,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (treeId.present) {
      map['tree_id'] = Variable<String>(treeId.value);
    }
    if (personId.present) {
      map['person_id'] = Variable<String>(personId.value);
    }
    if (relatedPersonId.present) {
      map['related_person_id'] = Variable<String>(relatedPersonId.value);
    }
    if (relationshipType.present) {
      map['relationship_type'] = Variable<String>(relationshipType.value);
    }
    if (subType.present) {
      map['sub_type'] = Variable<String>(subType.value);
    }
    if (isCurrent.present) {
      map['is_current'] = Variable<bool>(isCurrent.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (startDateApprox.present) {
      map['start_date_approx'] = Variable<bool>(startDateApprox.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<String>(endDate.value);
    }
    if (endDateApprox.present) {
      map['end_date_approx'] = Variable<bool>(endDateApprox.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RelationshipsCompanion(')
          ..write('id: $id, ')
          ..write('treeId: $treeId, ')
          ..write('personId: $personId, ')
          ..write('relatedPersonId: $relatedPersonId, ')
          ..write('relationshipType: $relationshipType, ')
          ..write('subType: $subType, ')
          ..write('isCurrent: $isCurrent, ')
          ..write('startDate: $startDate, ')
          ..write('startDateApprox: $startDateApprox, ')
          ..write('endDate: $endDate, ')
          ..write('endDateApprox: $endDateApprox, ')
          ..write('notes: $notes, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MediasTable extends Medias with TableInfo<$MediasTable, MediaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _treeIdMeta = const VerificationMeta('treeId');
  @override
  late final GeneratedColumn<String> treeId = GeneratedColumn<String>(
      'tree_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _personIdMeta =
      const VerificationMeta('personId');
  @override
  late final GeneratedColumn<String> personId = GeneratedColumn<String>(
      'person_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('PHOTO'));
  static const VerificationMeta _filePathMeta =
      const VerificationMeta('filePath');
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
      'file_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fileNameMeta =
      const VerificationMeta('fileName');
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
      'file_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fileSizeBytesMeta =
      const VerificationMeta('fileSizeBytes');
  @override
  late final GeneratedColumn<int> fileSizeBytes = GeneratedColumn<int>(
      'file_size_bytes', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _mimeTypeMeta =
      const VerificationMeta('mimeType');
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
      'mime_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateTakenMeta =
      const VerificationMeta('dateTaken');
  @override
  late final GeneratedColumn<String> dateTaken = GeneratedColumn<String>(
      'date_taken', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        treeId,
        personId,
        type,
        filePath,
        fileName,
        fileSizeBytes,
        mimeType,
        title,
        description,
        dateTaken,
        isDeleted,
        deletedAt,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medias';
  @override
  VerificationContext validateIntegrity(Insertable<MediaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tree_id')) {
      context.handle(_treeIdMeta,
          treeId.isAcceptableOrUnknown(data['tree_id']!, _treeIdMeta));
    } else if (isInserting) {
      context.missing(_treeIdMeta);
    }
    if (data.containsKey('person_id')) {
      context.handle(_personIdMeta,
          personId.isAcceptableOrUnknown(data['person_id']!, _personIdMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('file_path')) {
      context.handle(_filePathMeta,
          filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta));
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(_fileNameMeta,
          fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta));
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('file_size_bytes')) {
      context.handle(
          _fileSizeBytesMeta,
          fileSizeBytes.isAcceptableOrUnknown(
              data['file_size_bytes']!, _fileSizeBytesMeta));
    }
    if (data.containsKey('mime_type')) {
      context.handle(_mimeTypeMeta,
          mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('date_taken')) {
      context.handle(_dateTakenMeta,
          dateTaken.isAcceptableOrUnknown(data['date_taken']!, _dateTakenMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MediaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      treeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tree_id'])!,
      personId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}person_id']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      filePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_path'])!,
      fileName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_name'])!,
      fileSizeBytes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}file_size_bytes']),
      mimeType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mime_type']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      dateTaken: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date_taken']),
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}deleted_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $MediasTable createAlias(String alias) {
    return $MediasTable(attachedDatabase, alias);
  }
}

class MediaData extends DataClass implements Insertable<MediaData> {
  final String id;
  final String treeId;
  final String? personId;
  final String type;
  final String filePath;
  final String fileName;
  final int? fileSizeBytes;
  final String? mimeType;
  final String? title;
  final String? description;
  final String? dateTaken;
  final bool isDeleted;
  final String? deletedAt;
  final String createdAt;
  final String updatedAt;
  const MediaData(
      {required this.id,
      required this.treeId,
      this.personId,
      required this.type,
      required this.filePath,
      required this.fileName,
      this.fileSizeBytes,
      this.mimeType,
      this.title,
      this.description,
      this.dateTaken,
      required this.isDeleted,
      this.deletedAt,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tree_id'] = Variable<String>(treeId);
    if (!nullToAbsent || personId != null) {
      map['person_id'] = Variable<String>(personId);
    }
    map['type'] = Variable<String>(type);
    map['file_path'] = Variable<String>(filePath);
    map['file_name'] = Variable<String>(fileName);
    if (!nullToAbsent || fileSizeBytes != null) {
      map['file_size_bytes'] = Variable<int>(fileSizeBytes);
    }
    if (!nullToAbsent || mimeType != null) {
      map['mime_type'] = Variable<String>(mimeType);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || dateTaken != null) {
      map['date_taken'] = Variable<String>(dateTaken);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  MediasCompanion toCompanion(bool nullToAbsent) {
    return MediasCompanion(
      id: Value(id),
      treeId: Value(treeId),
      personId: personId == null && nullToAbsent
          ? const Value.absent()
          : Value(personId),
      type: Value(type),
      filePath: Value(filePath),
      fileName: Value(fileName),
      fileSizeBytes: fileSizeBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(fileSizeBytes),
      mimeType: mimeType == null && nullToAbsent
          ? const Value.absent()
          : Value(mimeType),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      dateTaken: dateTaken == null && nullToAbsent
          ? const Value.absent()
          : Value(dateTaken),
      isDeleted: Value(isDeleted),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MediaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaData(
      id: serializer.fromJson<String>(json['id']),
      treeId: serializer.fromJson<String>(json['treeId']),
      personId: serializer.fromJson<String?>(json['personId']),
      type: serializer.fromJson<String>(json['type']),
      filePath: serializer.fromJson<String>(json['filePath']),
      fileName: serializer.fromJson<String>(json['fileName']),
      fileSizeBytes: serializer.fromJson<int?>(json['fileSizeBytes']),
      mimeType: serializer.fromJson<String?>(json['mimeType']),
      title: serializer.fromJson<String?>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      dateTaken: serializer.fromJson<String?>(json['dateTaken']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'treeId': serializer.toJson<String>(treeId),
      'personId': serializer.toJson<String?>(personId),
      'type': serializer.toJson<String>(type),
      'filePath': serializer.toJson<String>(filePath),
      'fileName': serializer.toJson<String>(fileName),
      'fileSizeBytes': serializer.toJson<int?>(fileSizeBytes),
      'mimeType': serializer.toJson<String?>(mimeType),
      'title': serializer.toJson<String?>(title),
      'description': serializer.toJson<String?>(description),
      'dateTaken': serializer.toJson<String?>(dateTaken),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'deletedAt': serializer.toJson<String?>(deletedAt),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  MediaData copyWith(
          {String? id,
          String? treeId,
          Value<String?> personId = const Value.absent(),
          String? type,
          String? filePath,
          String? fileName,
          Value<int?> fileSizeBytes = const Value.absent(),
          Value<String?> mimeType = const Value.absent(),
          Value<String?> title = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> dateTaken = const Value.absent(),
          bool? isDeleted,
          Value<String?> deletedAt = const Value.absent(),
          String? createdAt,
          String? updatedAt}) =>
      MediaData(
        id: id ?? this.id,
        treeId: treeId ?? this.treeId,
        personId: personId.present ? personId.value : this.personId,
        type: type ?? this.type,
        filePath: filePath ?? this.filePath,
        fileName: fileName ?? this.fileName,
        fileSizeBytes:
            fileSizeBytes.present ? fileSizeBytes.value : this.fileSizeBytes,
        mimeType: mimeType.present ? mimeType.value : this.mimeType,
        title: title.present ? title.value : this.title,
        description: description.present ? description.value : this.description,
        dateTaken: dateTaken.present ? dateTaken.value : this.dateTaken,
        isDeleted: isDeleted ?? this.isDeleted,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  MediaData copyWithCompanion(MediasCompanion data) {
    return MediaData(
      id: data.id.present ? data.id.value : this.id,
      treeId: data.treeId.present ? data.treeId.value : this.treeId,
      personId: data.personId.present ? data.personId.value : this.personId,
      type: data.type.present ? data.type.value : this.type,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      fileSizeBytes: data.fileSizeBytes.present
          ? data.fileSizeBytes.value
          : this.fileSizeBytes,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      dateTaken: data.dateTaken.present ? data.dateTaken.value : this.dateTaken,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediaData(')
          ..write('id: $id, ')
          ..write('treeId: $treeId, ')
          ..write('personId: $personId, ')
          ..write('type: $type, ')
          ..write('filePath: $filePath, ')
          ..write('fileName: $fileName, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('mimeType: $mimeType, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('dateTaken: $dateTaken, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      treeId,
      personId,
      type,
      filePath,
      fileName,
      fileSizeBytes,
      mimeType,
      title,
      description,
      dateTaken,
      isDeleted,
      deletedAt,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaData &&
          other.id == this.id &&
          other.treeId == this.treeId &&
          other.personId == this.personId &&
          other.type == this.type &&
          other.filePath == this.filePath &&
          other.fileName == this.fileName &&
          other.fileSizeBytes == this.fileSizeBytes &&
          other.mimeType == this.mimeType &&
          other.title == this.title &&
          other.description == this.description &&
          other.dateTaken == this.dateTaken &&
          other.isDeleted == this.isDeleted &&
          other.deletedAt == this.deletedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MediasCompanion extends UpdateCompanion<MediaData> {
  final Value<String> id;
  final Value<String> treeId;
  final Value<String?> personId;
  final Value<String> type;
  final Value<String> filePath;
  final Value<String> fileName;
  final Value<int?> fileSizeBytes;
  final Value<String?> mimeType;
  final Value<String?> title;
  final Value<String?> description;
  final Value<String?> dateTaken;
  final Value<bool> isDeleted;
  final Value<String?> deletedAt;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> rowid;
  const MediasCompanion({
    this.id = const Value.absent(),
    this.treeId = const Value.absent(),
    this.personId = const Value.absent(),
    this.type = const Value.absent(),
    this.filePath = const Value.absent(),
    this.fileName = const Value.absent(),
    this.fileSizeBytes = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.dateTaken = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MediasCompanion.insert({
    required String id,
    required String treeId,
    this.personId = const Value.absent(),
    this.type = const Value.absent(),
    required String filePath,
    required String fileName,
    this.fileSizeBytes = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.dateTaken = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        treeId = Value(treeId),
        filePath = Value(filePath),
        fileName = Value(fileName),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<MediaData> custom({
    Expression<String>? id,
    Expression<String>? treeId,
    Expression<String>? personId,
    Expression<String>? type,
    Expression<String>? filePath,
    Expression<String>? fileName,
    Expression<int>? fileSizeBytes,
    Expression<String>? mimeType,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? dateTaken,
    Expression<bool>? isDeleted,
    Expression<String>? deletedAt,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (treeId != null) 'tree_id': treeId,
      if (personId != null) 'person_id': personId,
      if (type != null) 'type': type,
      if (filePath != null) 'file_path': filePath,
      if (fileName != null) 'file_name': fileName,
      if (fileSizeBytes != null) 'file_size_bytes': fileSizeBytes,
      if (mimeType != null) 'mime_type': mimeType,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (dateTaken != null) 'date_taken': dateTaken,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MediasCompanion copyWith(
      {Value<String>? id,
      Value<String>? treeId,
      Value<String?>? personId,
      Value<String>? type,
      Value<String>? filePath,
      Value<String>? fileName,
      Value<int?>? fileSizeBytes,
      Value<String?>? mimeType,
      Value<String?>? title,
      Value<String?>? description,
      Value<String?>? dateTaken,
      Value<bool>? isDeleted,
      Value<String?>? deletedAt,
      Value<String>? createdAt,
      Value<String>? updatedAt,
      Value<int>? rowid}) {
    return MediasCompanion(
      id: id ?? this.id,
      treeId: treeId ?? this.treeId,
      personId: personId ?? this.personId,
      type: type ?? this.type,
      filePath: filePath ?? this.filePath,
      fileName: fileName ?? this.fileName,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      mimeType: mimeType ?? this.mimeType,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTaken: dateTaken ?? this.dateTaken,
      isDeleted: isDeleted ?? this.isDeleted,
      deletedAt: deletedAt ?? this.deletedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (treeId.present) {
      map['tree_id'] = Variable<String>(treeId.value);
    }
    if (personId.present) {
      map['person_id'] = Variable<String>(personId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (fileSizeBytes.present) {
      map['file_size_bytes'] = Variable<int>(fileSizeBytes.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (dateTaken.present) {
      map['date_taken'] = Variable<String>(dateTaken.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediasCompanion(')
          ..write('id: $id, ')
          ..write('treeId: $treeId, ')
          ..write('personId: $personId, ')
          ..write('type: $type, ')
          ..write('filePath: $filePath, ')
          ..write('fileName: $fileName, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('mimeType: $mimeType, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('dateTaken: $dateTaken, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FamilyTreesTable familyTrees = $FamilyTreesTable(this);
  late final $PersonsTable persons = $PersonsTable(this);
  late final $RelationshipsTable relationships = $RelationshipsTable(this);
  late final $MediasTable medias = $MediasTable(this);
  late final FamilyTreeDao familyTreeDao = FamilyTreeDao(this as AppDatabase);
  late final PersonDao personDao = PersonDao(this as AppDatabase);
  late final RelationshipDao relationshipDao =
      RelationshipDao(this as AppDatabase);
  late final MediaDao mediaDao = MediaDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [familyTrees, persons, relationships, medias];
}

typedef $$FamilyTreesTableCreateCompanionBuilder = FamilyTreesCompanion
    Function({
  required String id,
  required String name,
  Value<String?> description,
  Value<String?> rootPersonId,
  required String createdAt,
  required String updatedAt,
  Value<int> rowid,
});
typedef $$FamilyTreesTableUpdateCompanionBuilder = FamilyTreesCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String?> description,
  Value<String?> rootPersonId,
  Value<String> createdAt,
  Value<String> updatedAt,
  Value<int> rowid,
});

class $$FamilyTreesTableFilterComposer
    extends Composer<_$AppDatabase, $FamilyTreesTable> {
  $$FamilyTreesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rootPersonId => $composableBuilder(
      column: $table.rootPersonId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$FamilyTreesTableOrderingComposer
    extends Composer<_$AppDatabase, $FamilyTreesTable> {
  $$FamilyTreesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rootPersonId => $composableBuilder(
      column: $table.rootPersonId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$FamilyTreesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FamilyTreesTable> {
  $$FamilyTreesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get rootPersonId => $composableBuilder(
      column: $table.rootPersonId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FamilyTreesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FamilyTreesTable,
    FamilyTreeData,
    $$FamilyTreesTableFilterComposer,
    $$FamilyTreesTableOrderingComposer,
    $$FamilyTreesTableAnnotationComposer,
    $$FamilyTreesTableCreateCompanionBuilder,
    $$FamilyTreesTableUpdateCompanionBuilder,
    (
      FamilyTreeData,
      BaseReferences<_$AppDatabase, $FamilyTreesTable, FamilyTreeData>
    ),
    FamilyTreeData,
    PrefetchHooks Function()> {
  $$FamilyTreesTableTableManager(_$AppDatabase db, $FamilyTreesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FamilyTreesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FamilyTreesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FamilyTreesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> rootPersonId = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FamilyTreesCompanion(
            id: id,
            name: name,
            description: description,
            rootPersonId: rootPersonId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> description = const Value.absent(),
            Value<String?> rootPersonId = const Value.absent(),
            required String createdAt,
            required String updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              FamilyTreesCompanion.insert(
            id: id,
            name: name,
            description: description,
            rootPersonId: rootPersonId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FamilyTreesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FamilyTreesTable,
    FamilyTreeData,
    $$FamilyTreesTableFilterComposer,
    $$FamilyTreesTableOrderingComposer,
    $$FamilyTreesTableAnnotationComposer,
    $$FamilyTreesTableCreateCompanionBuilder,
    $$FamilyTreesTableUpdateCompanionBuilder,
    (
      FamilyTreeData,
      BaseReferences<_$AppDatabase, $FamilyTreesTable, FamilyTreeData>
    ),
    FamilyTreeData,
    PrefetchHooks Function()>;
typedef $$PersonsTableCreateCompanionBuilder = PersonsCompanion Function({
  required String id,
  required String treeId,
  required String firstName,
  Value<String?> middleName,
  Value<String?> lastName,
  Value<String?> maidenName,
  Value<String?> nickname,
  Value<String> gender,
  Value<bool> isLiving,
  Value<String?> birthDate,
  Value<bool> birthDateApprox,
  Value<String?> deathDate,
  Value<bool> deathDateApprox,
  Value<String?> birthPlace,
  Value<String?> deathPlace,
  Value<String?> currentLocation,
  Value<String?> occupation,
  Value<String?> biography,
  Value<String?> nationality,
  Value<String?> education,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> address,
  Value<String?> website,
  Value<String?> profilePhotoPath,
  Value<bool> isDeleted,
  Value<String?> deletedAt,
  required String createdAt,
  required String updatedAt,
  Value<int> rowid,
});
typedef $$PersonsTableUpdateCompanionBuilder = PersonsCompanion Function({
  Value<String> id,
  Value<String> treeId,
  Value<String> firstName,
  Value<String?> middleName,
  Value<String?> lastName,
  Value<String?> maidenName,
  Value<String?> nickname,
  Value<String> gender,
  Value<bool> isLiving,
  Value<String?> birthDate,
  Value<bool> birthDateApprox,
  Value<String?> deathDate,
  Value<bool> deathDateApprox,
  Value<String?> birthPlace,
  Value<String?> deathPlace,
  Value<String?> currentLocation,
  Value<String?> occupation,
  Value<String?> biography,
  Value<String?> nationality,
  Value<String?> education,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> address,
  Value<String?> website,
  Value<String?> profilePhotoPath,
  Value<bool> isDeleted,
  Value<String?> deletedAt,
  Value<String> createdAt,
  Value<String> updatedAt,
  Value<int> rowid,
});

class $$PersonsTableFilterComposer
    extends Composer<_$AppDatabase, $PersonsTable> {
  $$PersonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get treeId => $composableBuilder(
      column: $table.treeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get middleName => $composableBuilder(
      column: $table.middleName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get maidenName => $composableBuilder(
      column: $table.maidenName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nickname => $composableBuilder(
      column: $table.nickname, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isLiving => $composableBuilder(
      column: $table.isLiving, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get birthDate => $composableBuilder(
      column: $table.birthDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get birthDateApprox => $composableBuilder(
      column: $table.birthDateApprox,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deathDate => $composableBuilder(
      column: $table.deathDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get deathDateApprox => $composableBuilder(
      column: $table.deathDateApprox,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get birthPlace => $composableBuilder(
      column: $table.birthPlace, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deathPlace => $composableBuilder(
      column: $table.deathPlace, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currentLocation => $composableBuilder(
      column: $table.currentLocation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get occupation => $composableBuilder(
      column: $table.occupation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get biography => $composableBuilder(
      column: $table.biography, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nationality => $composableBuilder(
      column: $table.nationality, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get education => $composableBuilder(
      column: $table.education, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get website => $composableBuilder(
      column: $table.website, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get profilePhotoPath => $composableBuilder(
      column: $table.profilePhotoPath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$PersonsTableOrderingComposer
    extends Composer<_$AppDatabase, $PersonsTable> {
  $$PersonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get treeId => $composableBuilder(
      column: $table.treeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get middleName => $composableBuilder(
      column: $table.middleName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get maidenName => $composableBuilder(
      column: $table.maidenName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nickname => $composableBuilder(
      column: $table.nickname, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isLiving => $composableBuilder(
      column: $table.isLiving, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get birthDate => $composableBuilder(
      column: $table.birthDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get birthDateApprox => $composableBuilder(
      column: $table.birthDateApprox,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deathDate => $composableBuilder(
      column: $table.deathDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get deathDateApprox => $composableBuilder(
      column: $table.deathDateApprox,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get birthPlace => $composableBuilder(
      column: $table.birthPlace, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deathPlace => $composableBuilder(
      column: $table.deathPlace, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currentLocation => $composableBuilder(
      column: $table.currentLocation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get occupation => $composableBuilder(
      column: $table.occupation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get biography => $composableBuilder(
      column: $table.biography, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nationality => $composableBuilder(
      column: $table.nationality, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get education => $composableBuilder(
      column: $table.education, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get website => $composableBuilder(
      column: $table.website, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get profilePhotoPath => $composableBuilder(
      column: $table.profilePhotoPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$PersonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersonsTable> {
  $$PersonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get treeId =>
      $composableBuilder(column: $table.treeId, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get middleName => $composableBuilder(
      column: $table.middleName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get maidenName => $composableBuilder(
      column: $table.maidenName, builder: (column) => column);

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<bool> get isLiving =>
      $composableBuilder(column: $table.isLiving, builder: (column) => column);

  GeneratedColumn<String> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<bool> get birthDateApprox => $composableBuilder(
      column: $table.birthDateApprox, builder: (column) => column);

  GeneratedColumn<String> get deathDate =>
      $composableBuilder(column: $table.deathDate, builder: (column) => column);

  GeneratedColumn<bool> get deathDateApprox => $composableBuilder(
      column: $table.deathDateApprox, builder: (column) => column);

  GeneratedColumn<String> get birthPlace => $composableBuilder(
      column: $table.birthPlace, builder: (column) => column);

  GeneratedColumn<String> get deathPlace => $composableBuilder(
      column: $table.deathPlace, builder: (column) => column);

  GeneratedColumn<String> get currentLocation => $composableBuilder(
      column: $table.currentLocation, builder: (column) => column);

  GeneratedColumn<String> get occupation => $composableBuilder(
      column: $table.occupation, builder: (column) => column);

  GeneratedColumn<String> get biography =>
      $composableBuilder(column: $table.biography, builder: (column) => column);

  GeneratedColumn<String> get nationality => $composableBuilder(
      column: $table.nationality, builder: (column) => column);

  GeneratedColumn<String> get education =>
      $composableBuilder(column: $table.education, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get website =>
      $composableBuilder(column: $table.website, builder: (column) => column);

  GeneratedColumn<String> get profilePhotoPath => $composableBuilder(
      column: $table.profilePhotoPath, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PersonsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PersonsTable,
    PersonData,
    $$PersonsTableFilterComposer,
    $$PersonsTableOrderingComposer,
    $$PersonsTableAnnotationComposer,
    $$PersonsTableCreateCompanionBuilder,
    $$PersonsTableUpdateCompanionBuilder,
    (PersonData, BaseReferences<_$AppDatabase, $PersonsTable, PersonData>),
    PersonData,
    PrefetchHooks Function()> {
  $$PersonsTableTableManager(_$AppDatabase db, $PersonsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> treeId = const Value.absent(),
            Value<String> firstName = const Value.absent(),
            Value<String?> middleName = const Value.absent(),
            Value<String?> lastName = const Value.absent(),
            Value<String?> maidenName = const Value.absent(),
            Value<String?> nickname = const Value.absent(),
            Value<String> gender = const Value.absent(),
            Value<bool> isLiving = const Value.absent(),
            Value<String?> birthDate = const Value.absent(),
            Value<bool> birthDateApprox = const Value.absent(),
            Value<String?> deathDate = const Value.absent(),
            Value<bool> deathDateApprox = const Value.absent(),
            Value<String?> birthPlace = const Value.absent(),
            Value<String?> deathPlace = const Value.absent(),
            Value<String?> currentLocation = const Value.absent(),
            Value<String?> occupation = const Value.absent(),
            Value<String?> biography = const Value.absent(),
            Value<String?> nationality = const Value.absent(),
            Value<String?> education = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> website = const Value.absent(),
            Value<String?> profilePhotoPath = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<String?> deletedAt = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PersonsCompanion(
            id: id,
            treeId: treeId,
            firstName: firstName,
            middleName: middleName,
            lastName: lastName,
            maidenName: maidenName,
            nickname: nickname,
            gender: gender,
            isLiving: isLiving,
            birthDate: birthDate,
            birthDateApprox: birthDateApprox,
            deathDate: deathDate,
            deathDateApprox: deathDateApprox,
            birthPlace: birthPlace,
            deathPlace: deathPlace,
            currentLocation: currentLocation,
            occupation: occupation,
            biography: biography,
            nationality: nationality,
            education: education,
            email: email,
            phone: phone,
            address: address,
            website: website,
            profilePhotoPath: profilePhotoPath,
            isDeleted: isDeleted,
            deletedAt: deletedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String treeId,
            required String firstName,
            Value<String?> middleName = const Value.absent(),
            Value<String?> lastName = const Value.absent(),
            Value<String?> maidenName = const Value.absent(),
            Value<String?> nickname = const Value.absent(),
            Value<String> gender = const Value.absent(),
            Value<bool> isLiving = const Value.absent(),
            Value<String?> birthDate = const Value.absent(),
            Value<bool> birthDateApprox = const Value.absent(),
            Value<String?> deathDate = const Value.absent(),
            Value<bool> deathDateApprox = const Value.absent(),
            Value<String?> birthPlace = const Value.absent(),
            Value<String?> deathPlace = const Value.absent(),
            Value<String?> currentLocation = const Value.absent(),
            Value<String?> occupation = const Value.absent(),
            Value<String?> biography = const Value.absent(),
            Value<String?> nationality = const Value.absent(),
            Value<String?> education = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> website = const Value.absent(),
            Value<String?> profilePhotoPath = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<String?> deletedAt = const Value.absent(),
            required String createdAt,
            required String updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              PersonsCompanion.insert(
            id: id,
            treeId: treeId,
            firstName: firstName,
            middleName: middleName,
            lastName: lastName,
            maidenName: maidenName,
            nickname: nickname,
            gender: gender,
            isLiving: isLiving,
            birthDate: birthDate,
            birthDateApprox: birthDateApprox,
            deathDate: deathDate,
            deathDateApprox: deathDateApprox,
            birthPlace: birthPlace,
            deathPlace: deathPlace,
            currentLocation: currentLocation,
            occupation: occupation,
            biography: biography,
            nationality: nationality,
            education: education,
            email: email,
            phone: phone,
            address: address,
            website: website,
            profilePhotoPath: profilePhotoPath,
            isDeleted: isDeleted,
            deletedAt: deletedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PersonsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PersonsTable,
    PersonData,
    $$PersonsTableFilterComposer,
    $$PersonsTableOrderingComposer,
    $$PersonsTableAnnotationComposer,
    $$PersonsTableCreateCompanionBuilder,
    $$PersonsTableUpdateCompanionBuilder,
    (PersonData, BaseReferences<_$AppDatabase, $PersonsTable, PersonData>),
    PersonData,
    PrefetchHooks Function()>;
typedef $$RelationshipsTableCreateCompanionBuilder = RelationshipsCompanion
    Function({
  required String id,
  required String treeId,
  required String personId,
  required String relatedPersonId,
  required String relationshipType,
  Value<String?> subType,
  Value<bool> isCurrent,
  Value<String?> startDate,
  Value<bool> startDateApprox,
  Value<String?> endDate,
  Value<bool> endDateApprox,
  Value<String?> notes,
  Value<bool> isDeleted,
  Value<String?> deletedAt,
  required String createdAt,
  required String updatedAt,
  Value<int> rowid,
});
typedef $$RelationshipsTableUpdateCompanionBuilder = RelationshipsCompanion
    Function({
  Value<String> id,
  Value<String> treeId,
  Value<String> personId,
  Value<String> relatedPersonId,
  Value<String> relationshipType,
  Value<String?> subType,
  Value<bool> isCurrent,
  Value<String?> startDate,
  Value<bool> startDateApprox,
  Value<String?> endDate,
  Value<bool> endDateApprox,
  Value<String?> notes,
  Value<bool> isDeleted,
  Value<String?> deletedAt,
  Value<String> createdAt,
  Value<String> updatedAt,
  Value<int> rowid,
});

class $$RelationshipsTableFilterComposer
    extends Composer<_$AppDatabase, $RelationshipsTable> {
  $$RelationshipsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get treeId => $composableBuilder(
      column: $table.treeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get personId => $composableBuilder(
      column: $table.personId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get relatedPersonId => $composableBuilder(
      column: $table.relatedPersonId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get relationshipType => $composableBuilder(
      column: $table.relationshipType,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subType => $composableBuilder(
      column: $table.subType, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCurrent => $composableBuilder(
      column: $table.isCurrent, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get startDateApprox => $composableBuilder(
      column: $table.startDateApprox,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get endDateApprox => $composableBuilder(
      column: $table.endDateApprox, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$RelationshipsTableOrderingComposer
    extends Composer<_$AppDatabase, $RelationshipsTable> {
  $$RelationshipsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get treeId => $composableBuilder(
      column: $table.treeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get personId => $composableBuilder(
      column: $table.personId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get relatedPersonId => $composableBuilder(
      column: $table.relatedPersonId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get relationshipType => $composableBuilder(
      column: $table.relationshipType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subType => $composableBuilder(
      column: $table.subType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCurrent => $composableBuilder(
      column: $table.isCurrent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get startDateApprox => $composableBuilder(
      column: $table.startDateApprox,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get endDateApprox => $composableBuilder(
      column: $table.endDateApprox,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$RelationshipsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RelationshipsTable> {
  $$RelationshipsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get treeId =>
      $composableBuilder(column: $table.treeId, builder: (column) => column);

  GeneratedColumn<String> get personId =>
      $composableBuilder(column: $table.personId, builder: (column) => column);

  GeneratedColumn<String> get relatedPersonId => $composableBuilder(
      column: $table.relatedPersonId, builder: (column) => column);

  GeneratedColumn<String> get relationshipType => $composableBuilder(
      column: $table.relationshipType, builder: (column) => column);

  GeneratedColumn<String> get subType =>
      $composableBuilder(column: $table.subType, builder: (column) => column);

  GeneratedColumn<bool> get isCurrent =>
      $composableBuilder(column: $table.isCurrent, builder: (column) => column);

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<bool> get startDateApprox => $composableBuilder(
      column: $table.startDateApprox, builder: (column) => column);

  GeneratedColumn<String> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<bool> get endDateApprox => $composableBuilder(
      column: $table.endDateApprox, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$RelationshipsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RelationshipsTable,
    RelationshipData,
    $$RelationshipsTableFilterComposer,
    $$RelationshipsTableOrderingComposer,
    $$RelationshipsTableAnnotationComposer,
    $$RelationshipsTableCreateCompanionBuilder,
    $$RelationshipsTableUpdateCompanionBuilder,
    (
      RelationshipData,
      BaseReferences<_$AppDatabase, $RelationshipsTable, RelationshipData>
    ),
    RelationshipData,
    PrefetchHooks Function()> {
  $$RelationshipsTableTableManager(_$AppDatabase db, $RelationshipsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RelationshipsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RelationshipsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RelationshipsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> treeId = const Value.absent(),
            Value<String> personId = const Value.absent(),
            Value<String> relatedPersonId = const Value.absent(),
            Value<String> relationshipType = const Value.absent(),
            Value<String?> subType = const Value.absent(),
            Value<bool> isCurrent = const Value.absent(),
            Value<String?> startDate = const Value.absent(),
            Value<bool> startDateApprox = const Value.absent(),
            Value<String?> endDate = const Value.absent(),
            Value<bool> endDateApprox = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<String?> deletedAt = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RelationshipsCompanion(
            id: id,
            treeId: treeId,
            personId: personId,
            relatedPersonId: relatedPersonId,
            relationshipType: relationshipType,
            subType: subType,
            isCurrent: isCurrent,
            startDate: startDate,
            startDateApprox: startDateApprox,
            endDate: endDate,
            endDateApprox: endDateApprox,
            notes: notes,
            isDeleted: isDeleted,
            deletedAt: deletedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String treeId,
            required String personId,
            required String relatedPersonId,
            required String relationshipType,
            Value<String?> subType = const Value.absent(),
            Value<bool> isCurrent = const Value.absent(),
            Value<String?> startDate = const Value.absent(),
            Value<bool> startDateApprox = const Value.absent(),
            Value<String?> endDate = const Value.absent(),
            Value<bool> endDateApprox = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<String?> deletedAt = const Value.absent(),
            required String createdAt,
            required String updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              RelationshipsCompanion.insert(
            id: id,
            treeId: treeId,
            personId: personId,
            relatedPersonId: relatedPersonId,
            relationshipType: relationshipType,
            subType: subType,
            isCurrent: isCurrent,
            startDate: startDate,
            startDateApprox: startDateApprox,
            endDate: endDate,
            endDateApprox: endDateApprox,
            notes: notes,
            isDeleted: isDeleted,
            deletedAt: deletedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RelationshipsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RelationshipsTable,
    RelationshipData,
    $$RelationshipsTableFilterComposer,
    $$RelationshipsTableOrderingComposer,
    $$RelationshipsTableAnnotationComposer,
    $$RelationshipsTableCreateCompanionBuilder,
    $$RelationshipsTableUpdateCompanionBuilder,
    (
      RelationshipData,
      BaseReferences<_$AppDatabase, $RelationshipsTable, RelationshipData>
    ),
    RelationshipData,
    PrefetchHooks Function()>;
typedef $$MediasTableCreateCompanionBuilder = MediasCompanion Function({
  required String id,
  required String treeId,
  Value<String?> personId,
  Value<String> type,
  required String filePath,
  required String fileName,
  Value<int?> fileSizeBytes,
  Value<String?> mimeType,
  Value<String?> title,
  Value<String?> description,
  Value<String?> dateTaken,
  Value<bool> isDeleted,
  Value<String?> deletedAt,
  required String createdAt,
  required String updatedAt,
  Value<int> rowid,
});
typedef $$MediasTableUpdateCompanionBuilder = MediasCompanion Function({
  Value<String> id,
  Value<String> treeId,
  Value<String?> personId,
  Value<String> type,
  Value<String> filePath,
  Value<String> fileName,
  Value<int?> fileSizeBytes,
  Value<String?> mimeType,
  Value<String?> title,
  Value<String?> description,
  Value<String?> dateTaken,
  Value<bool> isDeleted,
  Value<String?> deletedAt,
  Value<String> createdAt,
  Value<String> updatedAt,
  Value<int> rowid,
});

class $$MediasTableFilterComposer
    extends Composer<_$AppDatabase, $MediasTable> {
  $$MediasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get treeId => $composableBuilder(
      column: $table.treeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get personId => $composableBuilder(
      column: $table.personId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get filePath => $composableBuilder(
      column: $table.filePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fileName => $composableBuilder(
      column: $table.fileName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fileSizeBytes => $composableBuilder(
      column: $table.fileSizeBytes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mimeType => $composableBuilder(
      column: $table.mimeType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dateTaken => $composableBuilder(
      column: $table.dateTaken, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$MediasTableOrderingComposer
    extends Composer<_$AppDatabase, $MediasTable> {
  $$MediasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get treeId => $composableBuilder(
      column: $table.treeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get personId => $composableBuilder(
      column: $table.personId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get filePath => $composableBuilder(
      column: $table.filePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fileName => $composableBuilder(
      column: $table.fileName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fileSizeBytes => $composableBuilder(
      column: $table.fileSizeBytes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mimeType => $composableBuilder(
      column: $table.mimeType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dateTaken => $composableBuilder(
      column: $table.dateTaken, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$MediasTableAnnotationComposer
    extends Composer<_$AppDatabase, $MediasTable> {
  $$MediasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get treeId =>
      $composableBuilder(column: $table.treeId, builder: (column) => column);

  GeneratedColumn<String> get personId =>
      $composableBuilder(column: $table.personId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<int> get fileSizeBytes => $composableBuilder(
      column: $table.fileSizeBytes, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get dateTaken =>
      $composableBuilder(column: $table.dateTaken, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MediasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MediasTable,
    MediaData,
    $$MediasTableFilterComposer,
    $$MediasTableOrderingComposer,
    $$MediasTableAnnotationComposer,
    $$MediasTableCreateCompanionBuilder,
    $$MediasTableUpdateCompanionBuilder,
    (MediaData, BaseReferences<_$AppDatabase, $MediasTable, MediaData>),
    MediaData,
    PrefetchHooks Function()> {
  $$MediasTableTableManager(_$AppDatabase db, $MediasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MediasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MediasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MediasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> treeId = const Value.absent(),
            Value<String?> personId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> filePath = const Value.absent(),
            Value<String> fileName = const Value.absent(),
            Value<int?> fileSizeBytes = const Value.absent(),
            Value<String?> mimeType = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> dateTaken = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<String?> deletedAt = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MediasCompanion(
            id: id,
            treeId: treeId,
            personId: personId,
            type: type,
            filePath: filePath,
            fileName: fileName,
            fileSizeBytes: fileSizeBytes,
            mimeType: mimeType,
            title: title,
            description: description,
            dateTaken: dateTaken,
            isDeleted: isDeleted,
            deletedAt: deletedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String treeId,
            Value<String?> personId = const Value.absent(),
            Value<String> type = const Value.absent(),
            required String filePath,
            required String fileName,
            Value<int?> fileSizeBytes = const Value.absent(),
            Value<String?> mimeType = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> dateTaken = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<String?> deletedAt = const Value.absent(),
            required String createdAt,
            required String updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              MediasCompanion.insert(
            id: id,
            treeId: treeId,
            personId: personId,
            type: type,
            filePath: filePath,
            fileName: fileName,
            fileSizeBytes: fileSizeBytes,
            mimeType: mimeType,
            title: title,
            description: description,
            dateTaken: dateTaken,
            isDeleted: isDeleted,
            deletedAt: deletedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MediasTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MediasTable,
    MediaData,
    $$MediasTableFilterComposer,
    $$MediasTableOrderingComposer,
    $$MediasTableAnnotationComposer,
    $$MediasTableCreateCompanionBuilder,
    $$MediasTableUpdateCompanionBuilder,
    (MediaData, BaseReferences<_$AppDatabase, $MediasTable, MediaData>),
    MediaData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FamilyTreesTableTableManager get familyTrees =>
      $$FamilyTreesTableTableManager(_db, _db.familyTrees);
  $$PersonsTableTableManager get persons =>
      $$PersonsTableTableManager(_db, _db.persons);
  $$RelationshipsTableTableManager get relationships =>
      $$RelationshipsTableTableManager(_db, _db.relationships);
  $$MediasTableTableManager get medias =>
      $$MediasTableTableManager(_db, _db.medias);
}
