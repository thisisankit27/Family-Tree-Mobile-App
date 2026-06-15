// lib/features/member/presentation/screens/member_profile_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_util.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../../shared/widgets/person_avatar.dart';
import '../../../relationship/domain/entities/relationship_entity.dart';
import '../../../tree/presentation/providers/providers.dart';
import '../../domain/entities/person_entity.dart';

class MemberProfileScreen extends ConsumerWidget {
  const MemberProfileScreen({super.key, required this.personId});
  final String personId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personAsync = ref.watch(personDetailProvider(personId));

    return personAsync.when(
      data: (person) {
        if (person == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Member not found')),
          );
        }
        return _ProfileBody(person: person);
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: AppErrorWidget(error: e),
      ),
    );
  }
}

// ─── Profile Body ─────────────────────────────────────────────────────────────

class _ProfileBody extends ConsumerWidget {
  const _ProfileBody({required this.person});
  final PersonEntity person;

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Member?'),
        content: Text(
          'This will remove ${person.shortName} and all their relationships '
          'from the tree. This action can be undone within 30 days.',
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(ctx).colorScheme.error),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true) return;
    await ref.read(personRepositoryProvider).softDeletePerson(person.id);
    if (context.mounted) context.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Header ────────────────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () =>
                    context.push('/member/${person.id}/edit'),
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: cs.error),
                onPressed: () => _confirmDelete(context, ref),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _ProfileHeader(person: person),
            ),
          ),

          // ── Content ────────────────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Lifespan + occupation row
                _QuickFactsRow(person: person),
                const SizedBox(height: 20),

                // Relationships
                _RelationshipsSection(personId: person.id),
                const SizedBox(height: 20),

                // Personal Details
                if (_hasPersonalDetails(person))
                  _InfoSection(
                    title: 'Personal Details',
                    icon: Icons.person_outline,
                    items: [
                      if (person.birthDate != null)
                        _InfoRow('Born', person.birthDateDisplay),
                      if (person.birthPlace != null)
                        _InfoRow('Birthplace', person.birthPlace!),
                      if (!person.isLiving && person.deathDate != null)
                        _InfoRow('Died', person.deathDateDisplay),
                      if (person.deathPlace != null)
                        _InfoRow('Death place', person.deathPlace!),
                      if (person.nationality != null)
                        _InfoRow('Nationality', person.nationality!),
                      if (person.education != null)
                        _InfoRow('Education', person.education!),
                      if (person.age != null)
                        _InfoRow(person.isLiving ? 'Age' : 'Age at death',
                            '${person.age} years'),
                    ],
                  ),
                const SizedBox(height: 20),

                // Contact
                if (_hasContact(person))
                  _InfoSection(
                    title: 'Contact',
                    icon: Icons.contact_phone_outlined,
                    items: [
                      if (person.email != null)
                        _InfoRow('Email', person.email!),
                      if (person.phone != null)
                        _InfoRow('Phone', person.phone!),
                      if (person.address != null)
                        _InfoRow('Address', person.address!),
                      if (person.website != null)
                        _InfoRow('Website', person.website!),
                    ],
                  ),
                const SizedBox(height: 20),

                // Biography
                if (person.biography != null &&
                    person.biography!.trim().isNotEmpty)
                  _BiographySection(biography: person.biography!),

                const SizedBox(height: 80),
              ]),
            ),
          ),
        ],
      ),

      // Add Relationship FAB
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'profile_fab',
        icon: const Icon(Icons.link),
        label: const Text('Add Relationship'),
        onPressed: () => context.push('/relationship/add',
            extra: {'personId': person.id, 'treeId': person.treeId}),
      ),
    );
  }

  bool _hasPersonalDetails(PersonEntity p) =>
      p.birthDate != null ||
      p.birthPlace != null ||
      p.deathDate != null ||
      p.deathPlace != null ||
      p.nationality != null ||
      p.education != null;

  bool _hasContact(PersonEntity p) =>
      p.email != null ||
      p.phone != null ||
      p.address != null ||
      p.website != null;
}

// ─── Profile Header ───────────────────────────────────────────────────────────

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.person});
  final PersonEntity person;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primaryContainer, cs.surfaceContainerLow],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              PersonAvatar(person: person, radius: 44, showBorder: true),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      person.fullName,
                      style: tt.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (person.maidenName != null)
                      Text(
                        'née ${person.maidenName}',
                        style: tt.bodySmall
                            ?.copyWith(color: cs.onSurfaceVariant),
                      ),
                    const SizedBox(height: 4),
                    Row(children: [
                      GenderDot(gender: person.gender),
                      const SizedBox(width: 6),
                      Text(
                        person.gender.displayName,
                        style: tt.bodySmall
                            ?.copyWith(color: cs.onSurfaceVariant),
                      ),
                      if (!person.isLiving) ...[
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: cs.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text('Deceased',
                              style: tt.labelSmall
                                  ?.copyWith(color: cs.onSurfaceVariant)),
                        ),
                      ]
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Quick Facts ─────────────────────────────────────────────────────────────

class _QuickFactsRow extends StatelessWidget {
  const _QuickFactsRow({required this.person});
  final PersonEntity person;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        if (person.birthDate != null)
          _Chip(
              icon: Icons.cake_outlined, label: person.lifespan, color: cs.primary),
        const SizedBox(width: 8),
        if (person.occupation != null)
          Expanded(
            child: _Chip(
                icon: Icons.work_outline,
                label: person.occupation!,
                color: cs.secondary),
          ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip(
      {required this.icon, required this.label, required this.color});
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Relationships Section ────────────────────────────────────────────────────

class _RelationshipsSection extends ConsumerWidget {
  const _RelationshipsSection({required this.personId});
  final String personId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parentsAsync = ref.watch(parentsProvider(personId));
    final childrenAsync = ref.watch(childrenProvider(personId));
    final spousesAsync = ref.watch(spousesProvider(personId));
    final siblingsAsync = ref.watch(siblingsProvider(personId));
    final relRepo = ref.read(relationshipRepositoryProvider);

    return _SectionCard(
      title: 'Relationships',
      icon: Icons.family_restroom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _RelGroup(
              label: 'Parents',
              asyncValue: parentsAsync,
              emptyText: 'No parents recorded'),
          _RelGroup(
              label: 'Spouses / Partners',
              asyncValue: spousesAsync,
              emptyText: 'No spouse recorded'),
          _RelGroup(
              label: 'Children',
              asyncValue: childrenAsync,
              emptyText: 'No children recorded'),
          _SiblingGroup(
              siblingsAsync: siblingsAsync,
              relRepo: relRepo),
        ],
      ),
    );
  }
}

class _RelGroup extends StatelessWidget {
  const _RelGroup({
    required this.label,
    required this.asyncValue,
    required this.emptyText,
  });
  final String label;
  final AsyncValue<List<PersonEntity>> asyncValue;
  final String emptyText;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return asyncValue.when(
      data: (persons) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: tt.labelMedium
                    ?.copyWith(color: cs.onSurfaceVariant, fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            if (persons.isEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 12),
                child: Text(emptyText,
                    style: tt.bodySmall
                        ?.copyWith(color: cs.onSurfaceVariant)),
              )
            else
              ...persons.map((p) => _RelPersonTile(person: p)),
            const Divider(height: 24),
          ],
        );
      },
      loading: () => const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: LinearProgressIndicator()),
      error: (_, __) => const SizedBox(),
    );
  }
}

class _SiblingGroup extends ConsumerWidget {
  const _SiblingGroup(
      {required this.siblingsAsync, required this.relRepo});
  final AsyncValue<List<SiblingEntry>> siblingsAsync;
  final relRepo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return siblingsAsync.when(
      data: (siblings) {
        if (siblings.isEmpty) return const SizedBox();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Siblings',
                style: tt.labelMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            ...siblings.map((s) {
              final personAsync =
                  ref.watch(personDetailProvider(s.personId));
              return personAsync.when(
                data: (p) {
                  if (p == null) return const SizedBox();
                  return _RelPersonTile(
                    person: p,
                    badge: s.siblingType.displayName,
                  );
                },
                loading: () => const SizedBox(height: 40),
                error: (_, __) => const SizedBox(),
              );
            }),
          ],
        );
      },
      loading: () => const SizedBox(),
      error: (_, __) => const SizedBox(),
    );
  }
}

class _RelPersonTile extends StatelessWidget {
  const _RelPersonTile({required this.person, this.badge});
  final PersonEntity person;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: PersonAvatar(person: person, radius: 20),
      title: Text(person.shortName,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.w600)),
      subtitle: Text(person.lifespan,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: cs.onSurfaceVariant)),
      trailing: badge != null
          ? Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(badge!,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: cs.onPrimaryContainer)),
            )
          : null,
      onTap: () => context.push('/member/${person.id}'),
    );
  }
}

// ─── Info Section Card ────────────────────────────────────────────────────────

class _InfoSection extends StatelessWidget {
  const _InfoSection(
      {required this.title,
      required this.icon,
      required this.items});
  final String title;
  final IconData icon;
  final List<_InfoRow> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox();
    return _SectionCard(
      title: title,
      icon: icon,
      child: Column(
        children: items,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(label,
                style: tt.bodySmall
                    ?.copyWith(color: cs.onSurfaceVariant)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value,
                style: tt.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}

class _BiographySection extends StatefulWidget {
  const _BiographySection({required this.biography});
  final String biography;

  @override
  State<_BiographySection> createState() => _BiographySectionState();
}

class _BiographySectionState extends State<_BiographySection> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final short = widget.biography.length > 300;
    return _SectionCard(
      title: 'Biography',
      icon: Icons.article_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _expanded || !short
                ? widget.biography
                : '${widget.biography.substring(0, 300)}…',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (short)
            TextButton(
              onPressed: () => setState(() => _expanded = !_expanded),
              child: Text(_expanded ? 'Show less' : 'Read more'),
            ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard(
      {required this.title, required this.icon, required this.child});
  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(icon, size: 18, color: cs.primary),
              const SizedBox(width: 8),
              Text(title,
                  style: tt.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700)),
            ]),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}
