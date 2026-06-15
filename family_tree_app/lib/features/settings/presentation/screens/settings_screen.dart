// lib/features/settings/presentation/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../tree/presentation/providers/providers.dart';

// ─── Theme Mode Provider ──────────────────────────────────────────────────────

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

// ─── Settings Screen ──────────────────────────────────────────────────────────

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final currentTreeId = ref.watch(currentTreeIdProvider);
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // ── Appearance ────────────────────────────────────────────────
          _SectionHeader(title: 'Appearance'),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.brightness_6_outlined),
                  title: const Text('Theme'),
                  subtitle: Text(_themeName(themeMode)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showThemePicker(context, ref, themeMode),
                ),
              ],
            ),
          ),

          // ── Family Tree ───────────────────────────────────────────────
          _SectionHeader(title: 'Family Trees'),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.family_restroom),
                  title: const Text('Manage Trees'),
                  subtitle: const Text('Create, rename, or delete trees'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showManageTrees(context, ref),
                ),
                const Divider(height: 1, indent: 56),
                ListTile(
                  leading: const Icon(Icons.account_tree_outlined),
                  title: const Text('Set Root Person'),
                  subtitle: const Text('Anchor person for tree visualization'),
                  trailing: const Icon(Icons.chevron_right),
                  enabled: currentTreeId != null,
                  onTap: currentTreeId != null
                      ? () => _showRootPersonPicker(context, ref, currentTreeId)
                      : null,
                ),
              ],
            ),
          ),

          // ── About ─────────────────────────────────────────────────────
          _SectionHeader(title: 'About'),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('Version'),
                  trailing: Text(
                    AppConstants.appVersion,
                    style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                  ),
                ),
                const Divider(height: 1, indent: 56),
                ListTile(
                  leading: const Icon(Icons.code_outlined),
                  title: const Text('Architecture'),
                  subtitle: const Text(
                      'Flutter • Drift ORM • Riverpod • Clean Architecture'),
                ),
                const Divider(height: 1, indent: 56),
                ListTile(
                  leading: const Icon(Icons.storage_outlined),
                  title: const Text('Data Storage'),
                  subtitle: const Text(
                      'All data stored locally on device. No cloud, no tracking.'),
                ),
              ],
            ),
          ),

          // ── Danger Zone ───────────────────────────────────────────────
          _SectionHeader(title: 'Danger Zone'),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.delete_forever_outlined,
                      color: cs.error),
                  title: Text('Delete Current Tree',
                      style: TextStyle(color: cs.error)),
                  subtitle: const Text(
                      'Permanently removes the selected tree and all its members.'),
                  enabled: currentTreeId != null,
                  onTap: currentTreeId != null
                      ? () => _confirmDeleteTree(context, ref, currentTreeId)
                      : null,
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Footer
          Center(
            child: Text(
              '🌳 Family Tree App • v${AppConstants.appVersion}\n'
              'Built with Flutter & ❤️',
              textAlign: TextAlign.center,
              style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  String _themeName(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.light  => 'Light',
      ThemeMode.dark   => 'Dark',
      ThemeMode.system => 'Follow system',
    };
  }

  void _showThemePicker(
      BuildContext context, WidgetRef ref, ThemeMode current) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            ListTile(
              title: Text('Theme',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700)),
            ),
            ...ThemeMode.values.map((mode) => ListTile(
                  leading: Icon(_themeIcon(mode)),
                  title: Text(_themeName(mode)),
                  trailing: current == mode
                      ? Icon(Icons.check,
                          color: Theme.of(context).colorScheme.primary)
                      : null,
                  onTap: () {
                    ref.read(themeModeProvider.notifier).state = mode;
                    Navigator.pop(context);
                  },
                )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  IconData _themeIcon(ThemeMode mode) => switch (mode) {
        ThemeMode.light  => Icons.light_mode_outlined,
        ThemeMode.dark   => Icons.dark_mode_outlined,
        ThemeMode.system => Icons.brightness_auto_outlined,
      };

  void _showManageTrees(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => _ManageTreesSheet(ref: ref),
    );
  }

  Future<void> _showRootPersonPicker(
      BuildContext context, WidgetRef ref, String treeId) async {
    final persons =
        await ref.read(personRepositoryProvider).getPersonsByTree(treeId);
    if (!context.mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        builder: (ctx, scroll) => Column(
          children: [
            const SizedBox(height: 8),
            ListTile(
              title: Text('Set Root Person',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700)),
            ),
            Expanded(
              child: ListView.builder(
                controller: scroll,
                itemCount: persons.length,
                itemBuilder: (_, i) => ListTile(
                  title: Text(persons[i].shortName),
                  subtitle: Text(persons[i].lifespan),
                  onTap: () async {
                    await ref
                        .read(familyTreeRepositoryProvider)
                        .setRootPerson(treeId, persons[i].id);
                    if (context.mounted) Navigator.pop(ctx);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDeleteTree(
      BuildContext context, WidgetRef ref, String treeId) async {
    final tree = await ref.read(familyTreeRepositoryProvider).getTreeById(treeId);
    if (!context.mounted || tree == null) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Tree?'),
        content: Text(
          'This will permanently delete "${tree.name}" and all '
          '${tree.memberCount} members. This cannot be undone.',
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(ctx).colorScheme.error),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete Forever'),
          ),
        ],
      ),
    );

    if (confirm != true || !context.mounted) return;

    await ref.read(familyTreeRepositoryProvider).deleteTree(treeId);
    ref.read(currentTreeIdProvider.notifier).state = null;

    // Select the next available tree
    final remaining = await ref.read(familyTreeRepositoryProvider).getAllTrees();
    if (remaining.isNotEmpty && context.mounted) {
      ref.read(currentTreeIdProvider.notifier).state = remaining.first.id;
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tree deleted.')),
      );
    }
  }
}

// ─── Manage Trees Sheet ───────────────────────────────────────────────────────

class _ManageTreesSheet extends ConsumerWidget {
  const _ManageTreesSheet({required this.ref});
  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef widgetRef) {
    final treesAsync = widgetRef.watch(allTreesProvider);
    final currentId = widgetRef.watch(currentTreeIdProvider);
    final cs = Theme.of(context).colorScheme;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      builder: (ctx, scroll) => Column(
        children: [
          const SizedBox(height: 8),
          ListTile(
            title: Text('Manage Trees',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
            trailing: IconButton(
              icon: Icon(Icons.add_circle_outline, color: cs.primary),
              onPressed: () async {
                Navigator.pop(ctx);
                final name = await _showCreateDialog(context);
                if (name == null || name.trim().isEmpty) return;
                final tree = await widgetRef
                    .read(familyTreeRepositoryProvider)
                    .createTree(name: name.trim());
                widgetRef.read(currentTreeIdProvider.notifier).state = tree.id;
              },
            ),
          ),
          Expanded(
            child: treesAsync.when(
              data: (trees) => ListView.builder(
                controller: scroll,
                itemCount: trees.length,
                itemBuilder: (_, i) {
                  final t = trees[i];
                  return ListTile(
                    leading: Icon(
                      Icons.family_restroom,
                      color: t.id == currentId ? cs.primary : null,
                    ),
                    title: Text(t.name,
                        style: TextStyle(
                            fontWeight: t.id == currentId
                                ? FontWeight.w700
                                : FontWeight.w400)),
                    subtitle: Text('${t.memberCount} members'),
                    trailing: t.id == currentId
                        ? Icon(Icons.check, color: cs.primary)
                        : null,
                    onTap: () {
                      widgetRef.read(currentTreeIdProvider.notifier).state = t.id;
                      Navigator.pop(ctx);
                    },
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => AppErrorWidget(error: e),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _showCreateDialog(BuildContext context) {
    final ctrl = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New Family Tree'),
        content: TextField(
          controller: ctrl,
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
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, ctrl.text),
              child: const Text('Create')),
        ],
      ),
    );
  }
}

// ─── Section Header ───────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 6),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: cs.primary,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
      ),
    );
  }
}
