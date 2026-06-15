// lib/features/member/presentation/screens/add_edit_member_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/uuid_util.dart';
import '../../../tree/presentation/providers/providers.dart';
import '../../domain/entities/person_entity.dart';

class AddEditMemberScreen extends ConsumerStatefulWidget {
  const AddEditMemberScreen({super.key, this.personId, this.treeId});
  final String? personId;  // null = add mode
  final String? treeId;

  @override
  ConsumerState<AddEditMemberScreen> createState() =>
      _AddEditMemberScreenState();
}

class _AddEditMemberScreenState extends ConsumerState<AddEditMemberScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool _isEditMode = false;
  PersonEntity? _existingPerson;

  // Photo
  String? _photoPath;

  // Name
  final _firstNameCtrl = TextEditingController();
  final _middleNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _maidenNameCtrl = TextEditingController();
  final _nicknameCtrl = TextEditingController();

  // Demographics
  Gender _gender = Gender.unknown;
  bool _isLiving = true;

  // Dates
  final _birthDateCtrl = TextEditingController();
  bool _birthDateApprox = false;
  final _deathDateCtrl = TextEditingController();
  bool _deathDateApprox = false;

  // Places
  final _birthPlaceCtrl = TextEditingController();
  final _deathPlaceCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();

  // Personal
  final _occupationCtrl = TextEditingController();
  final _biographyCtrl = TextEditingController();
  final _nationalityCtrl = TextEditingController();
  final _educationCtrl = TextEditingController();

  // Contact
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _websiteCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.personId != null;
    if (_isEditMode) _loadPerson();
  }

  Future<void> _loadPerson() async {
    setState(() => _loading = true);
    final person = await ref
        .read(personRepositoryProvider)
        .getPersonById(widget.personId!);
    if (person == null || !mounted) return;
    _existingPerson = person;
    _photoPath = person.profilePhotoPath;
    _firstNameCtrl.text = person.firstName;
    _middleNameCtrl.text = person.middleName ?? '';
    _lastNameCtrl.text = person.lastName ?? '';
    _maidenNameCtrl.text = person.maidenName ?? '';
    _nicknameCtrl.text = person.nickname ?? '';
    _gender = person.gender;
    _isLiving = person.isLiving;
    _birthDateCtrl.text = person.birthDate ?? '';
    _birthDateApprox = person.birthDateApprox;
    _deathDateCtrl.text = person.deathDate ?? '';
    _deathDateApprox = person.deathDateApprox;
    _birthPlaceCtrl.text = person.birthPlace ?? '';
    _deathPlaceCtrl.text = person.deathPlace ?? '';
    _locationCtrl.text = person.currentLocation ?? '';
    _occupationCtrl.text = person.occupation ?? '';
    _biographyCtrl.text = person.biography ?? '';
    _nationalityCtrl.text = person.nationality ?? '';
    _educationCtrl.text = person.education ?? '';
    _emailCtrl.text = person.email ?? '';
    _phoneCtrl.text = person.phone ?? '';
    _addressCtrl.text = person.address ?? '';
    _websiteCtrl.text = person.website ?? '';
    setState(() => _loading = false);
  }

  @override
  void dispose() {
    for (final c in [
      _firstNameCtrl, _middleNameCtrl, _lastNameCtrl, _maidenNameCtrl,
      _nicknameCtrl, _birthDateCtrl, _deathDateCtrl, _birthPlaceCtrl,
      _deathPlaceCtrl, _locationCtrl, _occupationCtrl, _biographyCtrl,
      _nationalityCtrl, _educationCtrl, _emailCtrl, _phoneCtrl,
      _addressCtrl, _websiteCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickPhoto(ImageSource source) async {
    final picker = ImagePicker();
    final xFile = await picker.pickImage(
        source: source, maxWidth: 800, maxHeight: 800, imageQuality: 85);
    if (xFile == null) return;

    final dir = await getApplicationDocumentsDirectory();
    final fileName = 'photo_${UuidUtil.generate()}.jpg';
    final dest = File(p.join(dir.path, 'photos', fileName));
    await dest.parent.create(recursive: true);
    await File(xFile.path).copy(dest.path);

    setState(() => _photoPath = dest.path);
  }

  void _showPhotoPicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Take a photo'),
              onTap: () {
                Navigator.pop(context);
                _pickPhoto(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickPhoto(ImageSource.gallery);
              },
            ),
            if (_photoPath != null)
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text('Remove photo'),
                onTap: () {
                  setState(() => _photoPath = null);
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    try {
      final repo = ref.read(personRepositoryProvider);
      final treeId = widget.treeId ??
          _existingPerson?.treeId ??
          ref.read(currentTreeIdProvider)!;

      if (_isEditMode && _existingPerson != null) {
        final updated = _existingPerson!.copyWith(
          firstName: _firstNameCtrl.text.trim(),
          middleName: _middleNameCtrl.text.trim().isEmpty ? null : _middleNameCtrl.text.trim(),
          lastName: _lastNameCtrl.text.trim().isEmpty ? null : _lastNameCtrl.text.trim(),
          maidenName: _maidenNameCtrl.text.trim().isEmpty ? null : _maidenNameCtrl.text.trim(),
          nickname: _nicknameCtrl.text.trim().isEmpty ? null : _nicknameCtrl.text.trim(),
          gender: _gender,
          isLiving: _isLiving,
          birthDate: _birthDateCtrl.text.trim().isEmpty ? null : _birthDateCtrl.text.trim(),
          birthDateApprox: _birthDateApprox,
          deathDate: _deathDateCtrl.text.trim().isEmpty ? null : _deathDateCtrl.text.trim(),
          deathDateApprox: _deathDateApprox,
          birthPlace: _birthPlaceCtrl.text.trim().isEmpty ? null : _birthPlaceCtrl.text.trim(),
          deathPlace: _deathPlaceCtrl.text.trim().isEmpty ? null : _deathPlaceCtrl.text.trim(),
          currentLocation: _locationCtrl.text.trim().isEmpty ? null : _locationCtrl.text.trim(),
          occupation: _occupationCtrl.text.trim().isEmpty ? null : _occupationCtrl.text.trim(),
          biography: _biographyCtrl.text.trim().isEmpty ? null : _biographyCtrl.text.trim(),
          nationality: _nationalityCtrl.text.trim().isEmpty ? null : _nationalityCtrl.text.trim(),
          education: _educationCtrl.text.trim().isEmpty ? null : _educationCtrl.text.trim(),
          email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
          phone: _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),
          address: _addressCtrl.text.trim().isEmpty ? null : _addressCtrl.text.trim(),
          website: _websiteCtrl.text.trim().isEmpty ? null : _websiteCtrl.text.trim(),
          profilePhotoPath: _photoPath,
        );
        await repo.updatePerson(updated);
      } else {
        await repo.createPerson(
          treeId: treeId,
          firstName: _firstNameCtrl.text.trim(),
          middleName: _middleNameCtrl.text.trim().isEmpty ? null : _middleNameCtrl.text.trim(),
          lastName: _lastNameCtrl.text.trim().isEmpty ? null : _lastNameCtrl.text.trim(),
          maidenName: _maidenNameCtrl.text.trim().isEmpty ? null : _maidenNameCtrl.text.trim(),
          nickname: _nicknameCtrl.text.trim().isEmpty ? null : _nicknameCtrl.text.trim(),
          gender: _gender,
          isLiving: _isLiving,
          birthDate: _birthDateCtrl.text.trim().isEmpty ? null : _birthDateCtrl.text.trim(),
          birthDateApprox: _birthDateApprox,
          deathDate: _deathDateCtrl.text.trim().isEmpty ? null : _deathDateCtrl.text.trim(),
          deathDateApprox: _deathDateApprox,
          birthPlace: _birthPlaceCtrl.text.trim().isEmpty ? null : _birthPlaceCtrl.text.trim(),
          deathPlace: _deathPlaceCtrl.text.trim().isEmpty ? null : _deathPlaceCtrl.text.trim(),
          currentLocation: _locationCtrl.text.trim().isEmpty ? null : _locationCtrl.text.trim(),
          occupation: _occupationCtrl.text.trim().isEmpty ? null : _occupationCtrl.text.trim(),
          biography: _biographyCtrl.text.trim().isEmpty ? null : _biographyCtrl.text.trim(),
          nationality: _nationalityCtrl.text.trim().isEmpty ? null : _nationalityCtrl.text.trim(),
          education: _educationCtrl.text.trim().isEmpty ? null : _educationCtrl.text.trim(),
          email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
          phone: _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),
          address: _addressCtrl.text.trim().isEmpty ? null : _addressCtrl.text.trim(),
          website: _websiteCtrl.text.trim().isEmpty ? null : _websiteCtrl.text.trim(),
          profilePhotoPath: _photoPath,
        );
      }

      if (mounted) context.pop();
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  // ── Date Picker Helper ────────────────────────────────────────────────────

  Future<void> _pickDate(TextEditingController ctrl) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1500),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      ctrl.text =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Member' : 'Add Member'),
        actions: [
          if (_loading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2)),
            )
          else
            TextButton(
              onPressed: _save,
              child: const Text('Save',
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ),
        ],
      ),
      body: _loading && _isEditMode
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // ── Photo ─────────────────────────────────────────────
                  Center(
                    child: GestureDetector(
                      onTap: _showPhotoPicker,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 52,
                            backgroundColor: cs.primaryContainer,
                            backgroundImage: _photoPath != null
                                ? FileImage(File(_photoPath!))
                                : null,
                            child: _photoPath == null
                                ? Icon(Icons.person, size: 52, color: cs.primary)
                                : null,
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: cs.primary,
                              child: Icon(Icons.camera_alt,
                                  size: 16, color: cs.onPrimary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Name ──────────────────────────────────────────────
                  _sectionHeader('Name', Icons.badge_outlined),
                  _field(_firstNameCtrl, 'First Name *',
                      required: true,
                      textCapitalization: TextCapitalization.words),
                  _field(_middleNameCtrl, 'Middle Name',
                      textCapitalization: TextCapitalization.words),
                  _field(_lastNameCtrl, 'Last Name',
                      textCapitalization: TextCapitalization.words),
                  _field(_maidenNameCtrl, 'Maiden / Birth Name',
                      textCapitalization: TextCapitalization.words),
                  _field(_nicknameCtrl, 'Nickname'),
                  const SizedBox(height: 16),

                  // ── Demographics ─────────────────────────────────────
                  _sectionHeader('Demographics', Icons.person_outline),
                  _GenderSelector(
                    value: _gender,
                    onChanged: (g) => setState(() => _gender = g),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    title: const Text('Currently Living'),
                    value: _isLiving,
                    onChanged: (v) => setState(() => _isLiving = v),
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 16),

                  // ── Dates ─────────────────────────────────────────────
                  _sectionHeader('Dates', Icons.calendar_today_outlined),
                  _DateField(
                    controller: _birthDateCtrl,
                    label: 'Date of Birth',
                    isApprox: _birthDateApprox,
                    onApproxChanged: (v) =>
                        setState(() => _birthDateApprox = v),
                    onPickDate: () => _pickDate(_birthDateCtrl),
                  ),
                  if (!_isLiving) ...[
                    const SizedBox(height: 8),
                    _DateField(
                      controller: _deathDateCtrl,
                      label: 'Date of Death',
                      isApprox: _deathDateApprox,
                      onApproxChanged: (v) =>
                          setState(() => _deathDateApprox = v),
                      onPickDate: () => _pickDate(_deathDateCtrl),
                    ),
                  ],
                  const SizedBox(height: 16),

                  // ── Places ────────────────────────────────────────────
                  _sectionHeader('Places', Icons.place_outlined),
                  _field(_birthPlaceCtrl, 'Place of Birth',
                      textCapitalization: TextCapitalization.words),
                  if (!_isLiving)
                    _field(_deathPlaceCtrl, 'Place of Death',
                        textCapitalization: TextCapitalization.words),
                  _field(_locationCtrl, 'Current Location',
                      textCapitalization: TextCapitalization.words),
                  const SizedBox(height: 16),

                  // ── Personal ─────────────────────────────────────────
                  _sectionHeader('Personal', Icons.work_outline),
                  _field(_occupationCtrl, 'Occupation',
                      textCapitalization: TextCapitalization.words),
                  _field(_nationalityCtrl, 'Nationality',
                      textCapitalization: TextCapitalization.words),
                  _field(_educationCtrl, 'Education',
                      textCapitalization: TextCapitalization.words),
                  TextFormField(
                    controller: _biographyCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Biography / Notes',
                      alignLabelWithHint: true,
                    ),
                    maxLines: 5,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  const SizedBox(height: 16),

                  // ── Contact ───────────────────────────────────────────
                  _sectionHeader('Contact', Icons.contact_phone_outlined),
                  _field(_emailCtrl, 'Email',
                      keyboardType: TextInputType.emailAddress),
                  _field(_phoneCtrl, 'Phone',
                      keyboardType: TextInputType.phone),
                  _field(_addressCtrl, 'Address',
                      textCapitalization: TextCapitalization.words),
                  _field(_websiteCtrl, 'Website',
                      keyboardType: TextInputType.url),
                  const SizedBox(height: 80),
                ],
              ),
            ),
    );
  }

  Widget _sectionHeader(String title, IconData icon) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(children: [
        Icon(icon, size: 16, color: cs.primary),
        const SizedBox(width: 8),
        Text(title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700, color: cs.primary)),
        const SizedBox(width: 8),
        Expanded(child: Divider(color: cs.outlineVariant)),
      ]),
    );
  }

  Widget _field(
    TextEditingController ctrl,
    String label, {
    bool required = false,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: ctrl,
        decoration: InputDecoration(labelText: label),
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        validator: required
            ? (v) => (v == null || v.trim().isEmpty) ? '$label is required' : null
            : null,
      ),
    );
  }
}

// ─── Gender Selector ──────────────────────────────────────────────────────────

class _GenderSelector extends StatelessWidget {
  const _GenderSelector({required this.value, required this.onChanged});
  final Gender value;
  final ValueChanged<Gender> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gender',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: Gender.values.map((g) {
            return FilterChip(
              label: Text(g.displayName),
              selected: value == g,
              onSelected: (_) => onChanged(g),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// ─── Date Field with Approx Toggle ───────────────────────────────────────────

class _DateField extends StatelessWidget {
  const _DateField({
    required this.controller,
    required this.label,
    required this.isApprox,
    required this.onApproxChanged,
    required this.onPickDate,
  });
  final TextEditingController controller;
  final String label;
  final bool isApprox;
  final ValueChanged<bool> onApproxChanged;
  final VoidCallback onPickDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              hintText: 'YYYY-MM-DD or YYYY',
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today, size: 18),
                onPressed: onPickDate,
              ),
            ),
            keyboardType: TextInputType.datetime,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(value: isApprox, onChanged: (v) => onApproxChanged(v!)),
            Text('circa',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant)),
          ],
        ),
      ],
    );
  }
}
