// lib/features/relationship/presentation/screens/add_relationship_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/person_avatar.dart';
import '../../../tree/presentation/providers/providers.dart';
import '../../../member/domain/entities/person_entity.dart';

class AddRelationshipScreen extends ConsumerStatefulWidget {
  const AddRelationshipScreen({
    super.key,
    required this.personId,
    required this.treeId,
  });
  final String personId;
  final String treeId;

  @override
  ConsumerState<AddRelationshipScreen> createState() =>
      _AddRelationshipScreenState();
}

class _AddRelationshipScreenState
    extends ConsumerState<AddRelationshipScreen> {
  // Step 1: category
  _RelCategory? _category;

  // Step 2 — parent-child
  ParentSubType _parentSubType = ParentSubType.biological;
  PersonEntity? _selectedPerson;
  bool _currentPersonIsParent = true; // true = current is parent, false = current is child

  // Step 2 — spouse
  SpouseSubType _spouseSubType = SpouseSubType.married;
  final _startDateCtrl = TextEditingController();
  final _endDateCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  bool _saving = false;

  @override
  void dispose() {
    _startDateCtrl.dispose();
    _endDateCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_selectedPerson == null) return;
    setState(() => _saving = true);
    try {
      final relRepo = ref.read(relationshipRepositoryProvider);

      if (_category == _RelCategory.parentChild) {
        final parentId = _currentPersonIsParent
            ? widget.personId
            : _selectedPerson!.id;
        final childId = _currentPersonIsParent
            ? _selectedPerson!.id
            : widget.personId;
        await relRepo.addParentChildRelationship(
          treeId: widget.treeId,
          parentId: parentId,
          childId: childId,
          subType: _parentSubType,
        );
      } else {
        await relRepo.addSpouseRelationship(
          treeId: widget.treeId,
          personAId: widget.personId,
          personBId: _selectedPerson!.id,
          subType: _spouseSubType,
          startDate: _startDateCtrl.text.trim().isEmpty
              ? null
              : _startDateCtrl.text.trim(),
          endDate: _endDateCtrl.text.trim().isEmpty
              ? null
              : _endDateCtrl.text.trim(),
          notes: _notesCtrl.text.trim().isEmpty
              ? null
              : _notesCtrl.text.trim(),
        );
      }

      if (mounted) context.pop();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Relationship'),
        actions: [
          if (_saving)
            const Padding(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2)))
          else if (_selectedPerson != null)
            TextButton(
                onPressed: _save,
                child: const Text('Save',
                    style: TextStyle(fontWeight: FontWeight.w700))),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Step 1: Category ──────────────────────────────────────────
          _StepHeader(step: 1, title: 'Choose Relationship Type'),
          const SizedBox(height: 12),
          _CategorySelector(
            selected: _category,
            onSelect: (c) => setState(() {
              _category = c;
              _selectedPerson = null;
            }),
          ),

          if (_category != null) ...[
            const SizedBox(height: 24),

            // ── Step 2: Configure ─────────────────────────────────────
            _StepHeader(step: 2, title: 'Configure'),
            const SizedBox(height: 12),
            if (_category == _RelCategory.parentChild)
              _ParentChildConfig(
                currentPersonId: widget.personId,
                treeId: widget.treeId,
                subType: _parentSubType,
                isCurrentParent: _currentPersonIsParent,
                selectedPerson: _selectedPerson,
                onSubTypeChanged: (v) => setState(() => _parentSubType = v),
                onRoleChanged: (v) =>
                    setState(() => _currentPersonIsParent = v),
                onPersonSelected: (p) => setState(() => _selectedPerson = p),
              )
            else
              _SpouseConfig(
                treeId: widget.treeId,
                currentPersonId: widget.personId,
                subType: _spouseSubType,
                selectedPerson: _selectedPerson,
                startDateCtrl: _startDateCtrl,
                endDateCtrl: _endDateCtrl,
                notesCtrl: _notesCtrl,
                onSubTypeChanged: (v) => setState(() => _spouseSubType = v),
                onPersonSelected: (p) => setState(() => _selectedPerson = p),
              ),
          ],
        ],
      ),
    );
  }
}

// ─── Step Header ─────────────────────────────────────────────────────────────

class _StepHeader extends StatelessWidget {
  const _StepHeader({required this.step, required this.title});
  final int step;
  final String title;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(children: [
      CircleAvatar(
        radius: 14,
        backgroundColor: cs.primary,
        child: Text('$step',
            style: TextStyle(
                color: cs.onPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 12)),
      ),
      const SizedBox(width: 10),
      Text(title,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w700)),
    ]);
  }
}

// ─── Category Selector ────────────────────────────────────────────────────────

enum _RelCategory { parentChild, spouse }

class _CategorySelector extends StatelessWidget {
  const _CategorySelector({required this.selected, required this.onSelect});
  final _RelCategory? selected;
  final ValueChanged<_RelCategory> onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: _CatCard(
          icon: Icons.family_restroom,
          label: 'Parent / Child',
          selected: selected == _RelCategory.parentChild,
          onTap: () => onSelect(_RelCategory.parentChild),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: _CatCard(
          icon: Icons.favorite_outline,
          label: 'Spouse / Partner',
          selected: selected == _RelCategory.spouse,
          onTap: () => onSelect(_RelCategory.spouse),
        ),
      ),
    ]);
  }
}

class _CatCard extends StatelessWidget {
  const _CatCard({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      color: selected ? cs.primaryContainer : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(children: [
            Icon(icon,
                size: 32,
                color: selected ? cs.primary : cs.onSurfaceVariant),
            const SizedBox(height: 8),
            Text(label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: selected ? cs.primary : null),
                textAlign: TextAlign.center),
          ]),
        ),
      ),
    );
  }
}

// ─── Parent-Child Config ─────────────────────────────────────────────────────

class _ParentChildConfig extends ConsumerWidget {
  const _ParentChildConfig({
    required this.currentPersonId,
    required this.treeId,
    required this.subType,
    required this.isCurrentParent,
    required this.selectedPerson,
    required this.onSubTypeChanged,
    required this.onRoleChanged,
    required this.onPersonSelected,
  });
  final String currentPersonId;
  final String treeId;
  final ParentSubType subType;
  final bool isCurrentParent;
  final PersonEntity? selectedPerson;
  final ValueChanged<ParentSubType> onSubTypeChanged;
  final ValueChanged<bool> onRoleChanged;
  final ValueChanged<PersonEntity> onPersonSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPersonAsync = ref.watch(personDetailProvider(currentPersonId));

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Role selector
      currentPersonAsync.when(
        data: (p) => p == null
            ? const SizedBox()
            : _RoleToggle(
                personName: p.shortName,
                isCurrentParent: isCurrentParent,
                onChanged: onRoleChanged,
              ),
        loading: () => const LinearProgressIndicator(),
        error: (_, __) => const SizedBox(),
      ),
      const SizedBox(height: 16),

      // Sub-type
      Text('Relationship Type',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant)),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8,
        children: ParentSubType.values.map((s) {
          return FilterChip(
            label: Text(s.displayName),
            selected: subType == s,
            onSelected: (_) => onSubTypeChanged(s),
          );
        }).toList(),
      ),
      const SizedBox(height: 16),

      // Person picker
      Text(isCurrentParent ? 'Select Child' : 'Select Parent',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant)),
      const SizedBox(height: 8),
      _PersonPicker(
        treeId: treeId,
        excludeId: currentPersonId,
        selectedPerson: selectedPerson,
        onSelected: onPersonSelected,
      ),
    ]);
  }
}

class _RoleToggle extends StatelessWidget {
  const _RoleToggle({
    required this.personName,
    required this.isCurrentParent,
    required this.onChanged,
  });
  final String personName;
  final bool isCurrentParent;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Text('Role:'),
      const SizedBox(width: 8),
      SegmentedButton<bool>(
        segments: [
          ButtonSegment(
            value: true,
            label: Text('$personName is parent'),
          ),
          ButtonSegment(
            value: false,
            label: Text('$personName is child'),
          ),
        ],
        selected: {isCurrentParent},
        onSelectionChanged: (v) => onChanged(v.first),
      ),
    ]);
  }
}

// ─── Spouse Config ────────────────────────────────────────────────────────────

class _SpouseConfig extends StatelessWidget {
  const _SpouseConfig({
    required this.treeId,
    required this.currentPersonId,
    required this.subType,
    required this.selectedPerson,
    required this.startDateCtrl,
    required this.endDateCtrl,
    required this.notesCtrl,
    required this.onSubTypeChanged,
    required this.onPersonSelected,
  });
  final String treeId;
  final String currentPersonId;
  final SpouseSubType subType;
  final PersonEntity? selectedPerson;
  final TextEditingController startDateCtrl;
  final TextEditingController endDateCtrl;
  final TextEditingController notesCtrl;
  final ValueChanged<SpouseSubType> onSubTypeChanged;
  final ValueChanged<PersonEntity> onPersonSelected;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Relationship Status',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant)),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8,
        children: SpouseSubType.values.map((s) {
          return FilterChip(
            label: Text(s.displayName),
            selected: subType == s,
            onSelected: (_) => onSubTypeChanged(s),
          );
        }).toList(),
      ),
      const SizedBox(height: 16),
      TextFormField(
        controller: startDateCtrl,
        decoration: const InputDecoration(
          labelText: 'Start Date (marriage/union)',
          hintText: 'YYYY-MM-DD',
        ),
        keyboardType: TextInputType.datetime,
      ),
      const SizedBox(height: 12),
      if (subType == SpouseSubType.divorced ||
          subType == SpouseSubType.separated)
        TextFormField(
          controller: endDateCtrl,
          decoration: const InputDecoration(
            labelText: 'End Date',
            hintText: 'YYYY-MM-DD',
          ),
          keyboardType: TextInputType.datetime,
        ),
      const SizedBox(height: 12),
      TextFormField(
        controller: notesCtrl,
        decoration: const InputDecoration(labelText: 'Notes (optional)'),
        maxLines: 2,
      ),
      const SizedBox(height: 16),
      Text('Select Spouse / Partner',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant)),
      const SizedBox(height: 8),
      _PersonPicker(
        treeId: treeId,
        excludeId: currentPersonId,
        selectedPerson: selectedPerson,
        onSelected: onPersonSelected,
      ),
    ]);
  }
}

// ─── Person Picker ────────────────────────────────────────────────────────────

class _PersonPicker extends ConsumerStatefulWidget {
  const _PersonPicker({
    required this.treeId,
    required this.excludeId,
    required this.selectedPerson,
    required this.onSelected,
  });
  final String treeId;
  final String excludeId;
  final PersonEntity? selectedPerson;
  final ValueChanged<PersonEntity> onSelected;

  @override
  ConsumerState<_PersonPicker> createState() => _PersonPickerState();
}

class _PersonPickerState extends ConsumerState<_PersonPicker> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (widget.selectedPerson != null) {
      return Card(
        color: cs.primaryContainer,
        child: ListTile(
          leading: PersonAvatar(person: widget.selectedPerson!, radius: 20),
          title: Text(widget.selectedPerson!.shortName,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(widget.selectedPerson!.lifespan),
          trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => widget.onSelected(widget.selectedPerson!),
          ),
        ),
      );
    }

    final searchAsync = ref.watch(
      searchResultsProvider(SearchParams(widget.treeId, _query)),
    );

    return Column(children: [
      SearchBar(
        hintText: 'Search by name…',
        leading: const Icon(Icons.search),
        onChanged: (v) => setState(() => _query = v),
        elevation: WidgetStateProperty.all(0),
        backgroundColor:
            WidgetStateProperty.all(cs.surfaceContainerLow),
      ),
      const SizedBox(height: 8),
      SizedBox(
        height: 240,
        child: searchAsync.when(
          data: (persons) {
            final filtered =
                persons.where((p) => p.id != widget.excludeId).toList();
            if (filtered.isEmpty) {
              return Center(
                child: Text('No members found',
                    style: TextStyle(color: cs.onSurfaceVariant)),
              );
            }
            return ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                final p = filtered[i];
                return ListTile(
                  leading: PersonAvatar(person: p, radius: 18),
                  title: Text(p.shortName),
                  subtitle: Text(p.lifespan),
                  onTap: () => widget.onSelected(p),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ),
    ]);
  }
}
