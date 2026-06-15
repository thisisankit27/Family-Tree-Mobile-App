// lib/features/tree/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/person_avatar.dart';
import '../../../member/domain/entities/person_entity.dart';
import '../../domain/entities/family_tree_entity.dart';
import '../providers/providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Auto-select the first tree on startup
    WidgetsBinding.instance.addPostFrameCallback((_) => _autoSelectTree());
  }

  Future<void> _autoSelectTree() async {
    final currentId = ref.read(currentTreeIdProvider);
    if (currentId != null) return;
    final trees = await ref.read(familyTreeRepositoryProvider).getAllTrees();
    if (trees.isNotEmpty && mounted) {
      ref.read(currentTreeIdProvider.notifier).state = trees.first.id;
    }
  }

  Future<void> _createTree() async {
    final name = await _showCreateTreeDialog();
    if (name == null || name.trim().isEmpty) return;

    final repo = ref.read(familyTreeRepositoryProvider);
    final tree = await repo.createTree(name: name.trim());
    if (mounted) {
      ref.read(currentTreeIdProvider.notifier).state = tree.id;
    }
  }

  Future<String?> _showCreateTreeDialog() async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New Family Tree'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'e.g. Smith Family Tree',
            labelText: 'Tree Name',
          ),
          autofocus: true,
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, controller.text),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final treesAsync = ref.watch(allTreesProvider);
    final currentTreeId = ref.watch(currentTreeIdProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: treesAsync.when(
          data: (trees) {
            if (trees.isEmpty) return const Text('Family Tree');
            final current = trees.firstWhere(
              (t) => t.id == currentTreeId,
              orElse: () => trees.first,
            );
            return _TreeSelector(
              trees: trees,
              current: current,
              onSelect: (id) =>
                  ref.read(currentTreeIdProvider.notifier).state = id,
            );
          },
          loading: () => const Text('Family Tree'),
          error: (_, __) => const Text('Family Tree'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'New Tree',
            onPressed: _createTree,
          ),
          IconButton(
            icon: const Icon(Icons.account_tree_outlined),
            tooltip: 'View Tree',
            onPressed: currentTreeId == null
                ? null
                : () => context.push('/tree'),
          ),
        ],
      ),
      body: treesAsync.when(
        data: (trees) {
          if (trees.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.family_restroom,
              title: 'Start Your Family Tree',
              subtitle:
                  'Create your first family tree and begin preserving your family history.',
              actionLabel: 'Create First Tree',
              onAction: _createTree,
            );
          }
          final treeId = currentTreeId ?? trees.first.id;
          return _HomeBody(treeId: treeId);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => AppErrorWidget(error: e),
      ),
      floatingActionButton: currentTreeId == null
          ? null
          : FloatingActionButton.extended(
              heroTag: 'home_fab',
              onPressed: () => context.push('/member/add',
                  extra: {'treeId': currentTreeId}),
              icon: const Icon(Icons.person_add_outlined),
              label: const Text('Add Member'),
            ),
    );
  }
}

// ─── Home Body ────────────────────────────────────────────────────────────────

class _HomeBody extends ConsumerWidget {
  const _HomeBody({required this.treeId});
  final String treeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personsAsync = ref.watch(personsStreamProvider(treeId));
    final treeAsync = ref.watch(currentTreeProvider);
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return CustomScrollView(
      slivers: [
        // ── Stats Banner ───────────────────────────────────────────────────
        SliverToBoxAdapter(
          child: treeAsync.when(
            data: (tree) => tree == null
                ? const SizedBox()
                : _StatsBanner(tree: tree),
            loading: () => const SizedBox(height: 120),
            error: (_, __) => const SizedBox(),
          ),
        ),

        // ── Quick Actions ─────────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Quick Actions', style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                _QuickActionRow(treeId: treeId),
              ],
            ),
          ),
        ),

        // ── Recent Members ────────────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Recent Members',
              style: tt.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ),
        personsAsync.when(
          data: (persons) {
            if (persons.isEmpty) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Text(
                      'No members yet. Tap "Add Member" to get started.',
                      style: tt.bodyMedium
                          ?.copyWith(color: cs.onSurfaceVariant),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }
            final recent = persons.take(10).toList();
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => _RecentPersonTile(
                  person: recent[i],
                  onTap: () => ctx.push('/member/${recent[i].id}'),
                ),
                childCount: recent.length,
              ),
            );
          },
          loading: () => SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, __) => const PersonCardSkeleton(),
              childCount: 5,
            ),
          ),
          error: (e, _) => SliverToBoxAdapter(child: AppErrorWidget(error: e)),
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
      ],
    );
  }
}

// ─── Stats Banner ─────────────────────────────────────────────────────────────

class _StatsBanner extends StatelessWidget {
  const _StatsBanner({required this.tree});
  final FamilyTreeEntity tree;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primaryContainer, cs.secondaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.family_restroom, size: 28),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  tree.name,
                  style: tt.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (tree.description != null && tree.description!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(tree.description!,
                style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              _StatChip(
                icon: Icons.people,
                label: '${tree.memberCount}',
                sub: 'Members',
              ),
              const SizedBox(width: 12),
              _StatChip(
                icon: Icons.calendar_today,
                label: '${DateTime.now().year}',
                sub: 'Current Year',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.icon, required this.label, required this.sub});
  final IconData icon;
  final String label;
  final String sub;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: cs.surface.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: cs.primary),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w800)),
              Text(sub,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: cs.onSurfaceVariant)),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Quick Action Row ─────────────────────────────────────────────────────────

class _QuickActionRow extends StatelessWidget {
  const _QuickActionRow({required this.treeId});
  final String treeId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionCard(
            icon: Icons.account_tree,
            label: 'View Tree',
            color: Theme.of(context).colorScheme.primary,
            onTap: () => context.push('/tree'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ActionCard(
            icon: Icons.search,
            label: 'Search',
            color: Theme.of(context).colorScheme.secondary,
            onTap: () => context.push('/search', extra: {'treeId': treeId}),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ActionCard(
            icon: Icons.ios_share,
            label: 'Export',
            color: Theme.of(context).colorScheme.tertiary,
            onTap: () => context.go('/data'),
          ),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 6),
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Recent Person Tile ───────────────────────────────────────────────────────

class _RecentPersonTile extends StatelessWidget {
  const _RecentPersonTile({required this.person, required this.onTap});
  final PersonEntity person;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: PersonAvatar(person: person, radius: 24),
        title: Text(
          person.shortName,
          style: tt.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          person.lifespan,
          style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
        ),
        trailing: Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
        onTap: onTap,
      ),
    );
  }
}

// ─── Tree Selector ────────────────────────────────────────────────────────────

class _TreeSelector extends StatelessWidget {
  const _TreeSelector({
    required this.trees,
    required this.current,
    required this.onSelect,
  });
  final List<FamilyTreeEntity> trees;
  final FamilyTreeEntity current;
  final void Function(String) onSelect;

  @override
  Widget build(BuildContext context) {
    if (trees.length == 1) {
      return Text(
        current.name,
        style: const TextStyle(fontWeight: FontWeight.w700),
        overflow: TextOverflow.ellipsis,
      );
    }
    return GestureDetector(
      onTap: () => _showPicker(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              current.name,
              style: const TextStyle(fontWeight: FontWeight.w700),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(Icons.arrow_drop_down, size: 20),
        ],
      ),
    );
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          ListTile(
            title: Text(
              'Select Family Tree',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          ...trees.map((t) => ListTile(
                leading: Icon(
                  Icons.family_restroom,
                  color: t.id == current.id
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                title: Text(t.name),
                subtitle: Text('${t.memberCount} members'),
                trailing: t.id == current.id
                    ? Icon(Icons.check,
                        color: Theme.of(context).colorScheme.primary)
                    : null,
                onTap: () {
                  onSelect(t.id);
                  Navigator.pop(context);
                },
              )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
