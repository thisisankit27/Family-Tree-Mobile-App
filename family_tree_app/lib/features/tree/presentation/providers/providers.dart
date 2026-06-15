// lib/features/tree/presentation/providers/providers.dart
//
// Central provider file — all app-level providers live here for easy access.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../database/app_database.dart';
import '../../../tree/data/repositories/family_tree_repository_impl.dart';
import '../../../tree/domain/entities/family_tree_entity.dart';
import '../../../member/data/repositories/person_repository_impl.dart';
import '../../../member/domain/entities/person_entity.dart';
import '../../../relationship/data/repositories/relationship_repository_impl.dart';
import '../../../export_import/data/export_service.dart';

// ─── Infrastructure ───────────────────────────────────────────────────────────

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

// ─── Repositories ─────────────────────────────────────────────────────────────

final familyTreeRepositoryProvider = Provider<FamilyTreeRepository>((ref) {
  return FamilyTreeRepository(ref.watch(databaseProvider));
});

final personRepositoryProvider = Provider<PersonRepository>((ref) {
  return PersonRepository(ref.watch(databaseProvider));
});

final relationshipRepositoryProvider = Provider<RelationshipRepository>((ref) {
  return RelationshipRepository(ref.watch(databaseProvider));
});

final exportServiceProvider = Provider<ExportService>((ref) => ExportService());

// ─── Current Tree ─────────────────────────────────────────────────────────────

final currentTreeIdProvider = StateProvider<String?>((ref) => null);

final currentTreeProvider = FutureProvider<FamilyTreeEntity?>((ref) async {
  final id = ref.watch(currentTreeIdProvider);
  if (id == null) return null;
  return ref.watch(familyTreeRepositoryProvider).getTreeById(id);
});

// ─── Tree List ────────────────────────────────────────────────────────────────

final allTreesProvider = StreamProvider<List<FamilyTreeEntity>>((ref) {
  return ref.watch(familyTreeRepositoryProvider).watchAllTrees();
});

// ─── Person Streams (reactive, per-tree) ──────────────────────────────────────

final personsStreamProvider =
    StreamProvider.family<List<PersonEntity>, String>((ref, treeId) {
  return ref.watch(personRepositoryProvider).watchPersonsByTree(treeId);
});

// ─── Person Detail ────────────────────────────────────────────────────────────

final personDetailProvider =
    FutureProvider.family<PersonEntity?, String>((ref, personId) {
  return ref.watch(personRepositoryProvider).getPersonById(personId);
});

// ─── Relationships for a Person ───────────────────────────────────────────────

final parentsProvider =
    FutureProvider.family<List<PersonEntity>, String>((ref, personId) {
  return ref.watch(relationshipRepositoryProvider).getParentsOf(personId);
});

final childrenProvider =
    FutureProvider.family<List<PersonEntity>, String>((ref, personId) {
  return ref.watch(relationshipRepositoryProvider).getChildrenOf(personId);
});

final spousesProvider =
    FutureProvider.family<List<PersonEntity>, String>((ref, personId) {
  return ref.watch(relationshipRepositoryProvider).getSpousesOf(personId);
});

final siblingsProvider =
    FutureProvider.family<List<SiblingEntry>, String>((ref, personId) {
  return ref.watch(relationshipRepositoryProvider).getSiblingsOf(personId);
});

final relationshipsForPersonProvider =
    FutureProvider.family((ref, String personId) {
  return ref
      .watch(relationshipRepositoryProvider)
      .getRelationshipsForPerson(personId);
});

// ─── Search ───────────────────────────────────────────────────────────────────

class SearchParams {
  final String treeId;
  final String query;
  const SearchParams(this.treeId, this.query);
  @override
  bool operator ==(Object o) =>
      o is SearchParams && o.treeId == treeId && o.query == query;
  @override
  int get hashCode => Object.hash(treeId, query);
}

final searchResultsProvider =
    FutureProvider.family<List<PersonEntity>, SearchParams>((ref, params) {
  return ref
      .watch(personRepositoryProvider)
      .searchPersons(params.treeId, params.query);
});

// ─── Tree Visualization Graph ─────────────────────────────────────────────────

class TreeGraphParams {
  final String treeId;
  final String? anchorPersonId;
  const TreeGraphParams(this.treeId, this.anchorPersonId);
  @override
  bool operator ==(Object o) =>
      o is TreeGraphParams &&
      o.treeId == treeId &&
      o.anchorPersonId == anchorPersonId;
  @override
  int get hashCode => Object.hash(treeId, anchorPersonId);
}

final treeGraphDataProvider =
    FutureProvider.family<TreeGraphData, TreeGraphParams>((ref, params) async {
  final personRepo = ref.watch(personRepositoryProvider);
  final relRepo = ref.watch(relationshipRepositoryProvider);

  final persons = await personRepo.getPersonsByTree(params.treeId);
  final relationships =
      await relRepo.getAllRelationshipsByTree(params.treeId);

  return TreeGraphData(persons: persons, relationships: relationships);
});

class TreeGraphData {
  final List<PersonEntity> persons;
  final List<RelationshipEntity> relationships;
  const TreeGraphData(
      {required this.persons, required this.relationships});
}
