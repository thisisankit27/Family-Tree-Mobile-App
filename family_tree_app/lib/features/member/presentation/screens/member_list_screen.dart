// lib/features/member/presentation/screens/member_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/person_avatar.dart';
import '../../../tree/presentation/providers/providers.dart';
import '../../domain/entities/person_entity.dart';

enum _Filter { all, living, deceased }

class MemberListScreen extends ConsumerStatefulWidget {
  const MemberListScreen({super.key});

  @override
  ConsumerState<MemberListScreen> createState() => _MemberListScreenState();
}

class _MemberListScreenState extends ConsumerState<MemberListScreen> {
  final _searchController = TextEditingController();
  _Filter _filter = _Filter.all;
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<PersonEntity> _applyFilter(List<PersonEntity> persons) {
    var list = persons;

    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list = list
          .where((p) =>
              p.firstName.toLowerCase().contains(q) ||
              (p.lastName?.toLowerCase().contains(q) ?? false) ||
              (p.nickname?.toLowerCase().contains(q) ?? false) ||
              (p.occupation?.toLowerCase().contains(q) ?? false))
          .toList();
    }

    switch (_filter) {
      case _Filter.living:
        list = list.where((p) => p.isLiving).toList();
        break;
      case _Filter.deceased:
        list = list.where((p) => !p.isLiving).toList();
        break;
      case _Filter.all:
        break;
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final currentTreeId = ref.watch(currentTreeIdProvider);
    final cs = Theme.of(context).colorScheme;

    if (currentTreeId == null) {
      return const Scaffold(
        body: EmptyStateWidget(
          icon: Icons.family_restroom,
          title: 'No Tree Selected',
          subtitle: 'Go to Home and create or select a family tree first.',
        ),
      );
    }

    final personsAsync = ref.watch(personsStreamProvider(currentTreeId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {/* TODO: sort menu */},
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Search Bar ───────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Search members…',
              leading: const Icon(Icons.search),
              trailing: _searchQuery.isNotEmpty
                  ? [
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    ]
                  : null,
              onChanged: (v) => setState(() => _searchQuery = v),
              elevation: WidgetStateProperty.all(0),
              backgroundColor: WidgetStateProperty.all(cs.surfaceContainerLow),
            ),
          ),

          // ── Filter Chips ─────────────────────────────────────────────────
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: _Filter.values.map((f) {
                final labels = {
                  _Filter.all: 'All',
                  _Filter.living: 'Living',
                  _Filter.deceased: 'Deceased',
                };
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(labels[f]!),
                    selected: _filter == f,
                    onSelected: (_) => setState(() => _filter = f),
                  ),
                );
              }).toList(),
            ),
          ),

          // ── List ─────────────────────────────────────────────────────────
          Expanded(
            child: personsAsync.when(
              data: (persons) {
                final filtered = _applyFilter(persons);
                if (persons.isEmpty) {
                  return EmptyStateWidget(
                    icon: Icons.people_outline,
                    title: 'No Members Yet',
                    subtitle: 'Tap the button below to add your first family member.',
                    actionLabel: 'Add Member',
                    onAction: () => context.push('/member/add',
                        extra: {'treeId': currentTreeId}),
                  );
                }
                if (filtered.isEmpty) {
                  return const Center(
                    child: Text('No members match your search or filter.'),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: filtered.length,
                  itemBuilder: (ctx, i) => _PersonTile(person: filtered[i]),
                );
              },
              loading: () => ListView.builder(
                itemCount: 8,
                itemBuilder: (_, __) => const PersonCardSkeleton(),
              ),
              error: (e, _) => AppErrorWidget(error: e),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'members_fab',
        onPressed: () => context.push('/member/add',
            extra: {'treeId': currentTreeId}),
        icon: const Icon(Icons.person_add_outlined),
        label: const Text('Add Member'),
      ),
    );
  }
}

// ─── Person Tile ──────────────────────────────────────────────────────────────

class _PersonTile extends StatelessWidget {
  const _PersonTile({required this.person});
  final PersonEntity person;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: PersonAvatar(person: person, radius: 26),
        title: Text(
          person.shortName,
          style: tt.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              person.lifespan,
              style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
            ),
            if (person.occupation != null && person.occupation!.isNotEmpty)
              Text(
                person.occupation!,
                style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!person.isLiving)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Deceased',
                  style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
                ),
              ),
            const SizedBox(width: 4),
            Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
          ],
        ),
        onTap: () => context.push('/member/${person.id}'),
      ),
    );
  }
}
