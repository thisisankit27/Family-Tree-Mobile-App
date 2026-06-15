// lib/features/search/presentation/screens/search_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/person_avatar.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../tree/presentation/providers/providers.dart';
import '../../../member/domain/entities/person_entity.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key, required this.treeId});
  final String treeId;

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _ctrl = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final resultsAsync = ref.watch(
      searchResultsProvider(SearchParams(widget.treeId, _query)),
    );

    return Scaffold(
      appBar: AppBar(
        title: SearchBar(
          controller: _ctrl,
          hintText: 'Search family members…',
          leading: const Icon(Icons.search),
          trailing: _query.isNotEmpty
              ? [
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _ctrl.clear();
                      setState(() => _query = '');
                    },
                  )
                ]
              : null,
          onChanged: (v) => setState(() => _query = v),
          autoFocus: true,
          elevation: WidgetStateProperty.all(0),
          backgroundColor:
              WidgetStateProperty.all(cs.surfaceContainerLow),
        ),
        titleSpacing: 0,
      ),
      body: _query.isEmpty
          ? const EmptyStateWidget(
              icon: Icons.search,
              title: 'Search Your Family',
              subtitle:
                  'Type a name, occupation, or nickname to find family members.',
            )
          : resultsAsync.when(
              data: (persons) {
                if (persons.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off,
                            size: 56, color: cs.onSurfaceVariant),
                        const SizedBox(height: 16),
                        Text('No results for "$_query"',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium),
                        const SizedBox(height: 8),
                        Text('Try a different name or spelling.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: cs.onSurfaceVariant)),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 80),
                  itemCount: persons.length,
                  itemBuilder: (ctx, i) =>
                      _SearchResultTile(person: persons[i]),
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => AppErrorWidget(error: e),
            ),
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  const _SearchResultTile({required this.person});
  final PersonEntity person;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: PersonAvatar(person: person, radius: 24),
      title: Text(person.shortName,
          style: tt.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(person.lifespan,
              style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
          if (person.occupation != null)
            Text(person.occupation!,
                style: tt.bodySmall
                    ?.copyWith(color: cs.onSurfaceVariant),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
        ],
      ),
      trailing: Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
      onTap: () => context.push('/member/${person.id}'),
    );
  }
}
