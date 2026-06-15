// lib/features/export_import/presentation/screens/export_import_screen.dart
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../relationship/data/repositories/relationship_repository_impl.dart';
import '../../../tree/presentation/providers/providers.dart';

class ExportImportScreen extends ConsumerStatefulWidget {
  const ExportImportScreen({super.key});

  @override
  ConsumerState<ExportImportScreen> createState() =>
      _ExportImportScreenState();
}

class _ExportImportScreenState extends ConsumerState<ExportImportScreen> {
  bool _loading = false;
  String? _statusMessage;
  bool _isError = false;

  void _setStatus(String message, {bool error = false}) {
    setState(() {
      _statusMessage = message;
      _isError = error;
    });
  }

  Future<void> _exportJson() async {
    final treeId = ref.read(currentTreeIdProvider);
    if (treeId == null) {
      _setStatus('Please select a family tree first.', error: true);
      return;
    }

    setState(() {
      _loading = true;
      _statusMessage = null;
    });

    try {
      final treeRepo = ref.read(familyTreeRepositoryProvider);
      final personRepo = ref.read(personRepositoryProvider);
      final relRepo = ref.read(relationshipRepositoryProvider);
      final exportSvc = ref.read(exportServiceProvider);

      final tree = await treeRepo.getTreeById(treeId);
      if (tree == null) throw Exception('Tree not found');

      final persons = await personRepo.getPersonsByTree(treeId);
      final rels = await relRepo.getAllRelationshipsByTree(treeId);

      final json = exportSvc.exportToJson(
          tree: tree, persons: persons, relationships: rels);
      final file = await exportSvc.saveJsonToFile(json, tree.name);

      await Share.shareXFiles(
        [XFile(file.path)],
        subject: '${tree.name} — Family Tree Backup',
        text:
            'Family tree data exported from Family Tree App.',
      );

      _setStatus(
          '✅ Exported ${persons.length} members to JSON successfully.');
    } catch (e) {
      _setStatus('Export failed: $e', error: true);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _exportPdf() async {
    final treeId = ref.read(currentTreeIdProvider);
    if (treeId == null) {
      _setStatus('Please select a family tree first.', error: true);
      return;
    }

    setState(() {
      _loading = true;
      _statusMessage = null;
    });

    try {
      final treeRepo = ref.read(familyTreeRepositoryProvider);
      final personRepo = ref.read(personRepositoryProvider);
      final exportSvc = ref.read(exportServiceProvider);

      final tree = await treeRepo.getTreeById(treeId);
      if (tree == null) throw Exception('Tree not found');

      final persons = await personRepo.getPersonsByTree(treeId);

      final file =
          await exportSvc.exportToPdf(tree: tree, persons: persons);

      await Share.shareXFiles(
        [XFile(file.path)],
        subject: '${tree.name} — Family Tree Report',
      );

      _setStatus(
          '✅ PDF exported with ${persons.length} members.');
    } catch (e) {
      _setStatus('PDF export failed: $e', error: true);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _importJson() async {
    setState(() {
      _loading = true;
      _statusMessage = null;
    });

    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        dialogTitle: 'Select a Family Tree backup (.json)',
      );

      if (result == null || result.files.isEmpty) {
        setState(() => _loading = false);
        return;
      }

      final filePath = result.files.single.path!;
      final content = await File(filePath).readAsString();

      final exportSvc = ref.read(exportServiceProvider);
      final importData = exportSvc.parseImportJson(content);

      // Confirm with user
      if (!mounted) return;
      final confirm = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Import Family Tree?'),
          content: Text(
            'This will import "${importData.tree.name}" with '
            '${importData.persons.length} members and '
            '${importData.relationships.length} relationships.\n\n'
            'The existing tree (if any) will NOT be deleted. '
            'A new tree will be added to your list.',
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel')),
            FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Import')),
          ],
        ),
      );

      if (confirm != true) {
        setState(() => _loading = false);
        return;
      }

      // Perform atomic import
      final treeRepo = ref.read(familyTreeRepositoryProvider);
      final personRepo = ref.read(personRepositoryProvider);
      final relRepo = ref.read(relationshipRepositoryProvider);

      // Create the tree
      final tree = await treeRepo.createTree(
        name: importData.tree.name,
        description: importData.tree.description,
      );

      // Import persons and keep a map from backup IDs to newly created IDs.
      final personIdMap = <String, String>{};
      for (final p in importData.persons) {
        final importedPerson = await personRepo.createPerson(
          treeId: tree.id,
          firstName: p.firstName,
          middleName: p.middleName,
          lastName: p.lastName,
          maidenName: p.maidenName,
          nickname: p.nickname,
          gender: p.gender,
          isLiving: p.isLiving,
          birthDate: p.birthDate,
          birthDateApprox: p.birthDateApprox,
          deathDate: p.deathDate,
          deathDateApprox: p.deathDateApprox,
          birthPlace: p.birthPlace,
          deathPlace: p.deathPlace,
          currentLocation: p.currentLocation,
          occupation: p.occupation,
          biography: p.biography,
          nationality: p.nationality,
          education: p.education,
          email: p.email,
          phone: p.phone,
          address: p.address,
          website: p.website,
          profilePhotoPath: p.profilePhotoPath,
        );
        personIdMap[p.id] = importedPerson.id;
      }

      // Import relationships
      for (final r in importData.relationships) {
        try {
          final personId = personIdMap[r.personId];
          final relatedPersonId = personIdMap[r.relatedPersonId];
          if (personId == null || relatedPersonId == null) continue;

          if (r.relationshipType.value == 'PARENT_OF') {
            await relRepo.addParentChildRelationship(
              treeId: tree.id,
              parentId: personId,
              childId: relatedPersonId,
              subType: r.subType != null
                  ? ParentSubType.fromValue(r.subType!)
                  : ParentSubType.biological,
            );
          } else if (r.relationshipType.value == 'SPOUSE_OF') {
            await relRepo.addSpouseRelationship(
              treeId: tree.id,
              personAId: personId,
              personBId: relatedPersonId,
              subType: r.subType != null
                  ? SpouseSubType.fromValue(r.subType!)
                  : SpouseSubType.married,
              startDate: r.startDate,
              endDate: r.endDate,
            );
          }
        } catch (_) {
          // Skip duplicate relationships
        }
      }

      // Switch to imported tree
      ref.read(currentTreeIdProvider.notifier).state = tree.id;

      _setStatus(
        '✅ Import complete! "${tree.name}" with '
        '${importData.persons.length} members.',
      );
    } catch (e) {
      _setStatus('Import failed: $e', error: true);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final treeId = ref.watch(currentTreeIdProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Import & Export')),
      body: _loading
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Processing…'),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Status banner
                if (_statusMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _isError
                          ? cs.errorContainer
                          : cs.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _statusMessage!,
                      style: tt.bodyMedium?.copyWith(
                        color: _isError
                            ? cs.onErrorContainer
                            : cs.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // ── Export ─────────────────────────────────────────────
                Text('Export',
                    style: tt.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(
                  'Save or share your family tree data.',
                  style: tt.bodySmall
                      ?.copyWith(color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: 16),
                _ActionCard(
                  icon: Icons.data_object,
                  title: 'Export to JSON',
                  subtitle:
                      'Full backup of all members, relationships, and data. Use for restoring or transferring.',
                  color: cs.primary,
                  enabled: treeId != null,
                  onTap: _exportJson,
                ),
                const SizedBox(height: 12),
                _ActionCard(
                  icon: Icons.picture_as_pdf_outlined,
                  title: 'Export to PDF',
                  subtitle:
                      'Printable report of all family members with their details and biography.',
                  color: cs.secondary,
                  enabled: treeId != null,
                  onTap: _exportPdf,
                ),
                const SizedBox(height: 28),

                // ── Import ─────────────────────────────────────────────
                Text('Import',
                    style: tt.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(
                  'Restore a previously exported tree.',
                  style: tt.bodySmall
                      ?.copyWith(color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: 16),
                _ActionCard(
                  icon: Icons.upload_file_outlined,
                  title: 'Import from JSON',
                  subtitle:
                      'Load a Family Tree App backup file (.json). This creates a new tree — existing data is kept.',
                  color: cs.tertiary,
                  enabled: true,
                  onTap: _importJson,
                ),

                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: cs.outlineVariant),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline,
                          size: 20, color: cs.onSurfaceVariant),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Tip: Export your tree regularly and save the JSON file to cloud storage as a backup.',
                          style: tt.bodySmall
                              ?.copyWith(color: cs.onSurfaceVariant),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.enabled,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: enabled
                      ? color.withOpacity(0.15)
                      : cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon,
                    color: enabled ? color : cs.onSurfaceVariant,
                    size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: cs.onSurfaceVariant)),
                  ],
                ),
              ),
              Icon(Icons.chevron_right,
                  color: enabled ? cs.onSurface : cs.outlineVariant),
            ],
          ),
        ),
      ),
    );
  }
}
