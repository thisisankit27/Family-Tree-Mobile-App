// lib/features/visualization/presentation/screens/tree_visualization_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/empty_state_widget.dart';
import '../../../tree/presentation/providers/providers.dart';
import '../../algorithms/family_tree_layout.dart';
import '../../models/tree_node_model.dart';
import '../../widgets/tree_canvas.dart';

class TreeVisualizationScreen extends ConsumerStatefulWidget {
  const TreeVisualizationScreen({super.key});

  @override
  ConsumerState<TreeVisualizationScreen> createState() =>
      _TreeVisualizationScreenState();
}

class _TreeVisualizationScreenState
    extends ConsumerState<TreeVisualizationScreen> {
  final _transformCtrl = TransformationController();
  final _layoutAlgo = FamilyTreeLayout();

  @override
  void dispose() {
    _transformCtrl.dispose();
    super.dispose();
  }

  void _centerView(TreeLayoutResult layout) {
    if (layout.isEmpty) return;
    final scale = 0.85;
    final screenSize = MediaQuery.of(context).size;
    final tx = (screenSize.width - layout.canvasWidth * scale) / 2;
    final ty = (screenSize.height - layout.canvasHeight * scale) / 3;
    _transformCtrl.value = Matrix4.identity()
      ..scale(scale)
      ..translate(tx / scale, ty / scale);
  }

  void _zoomIn() {
    final current = _transformCtrl.value.clone();
    current.scale(1.25, 1.25);
    _transformCtrl.value = current;
  }

  void _zoomOut() {
    final current = _transformCtrl.value.clone();
    current.scale(0.8, 0.8);
    _transformCtrl.value = current;
  }

  @override
  Widget build(BuildContext context) {
    final treeId = ref.watch(currentTreeIdProvider);
    final cs = Theme.of(context).colorScheme;

    if (treeId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Family Tree')),
        body: const EmptyStateWidget(
          icon: Icons.account_tree_outlined,
          title: 'No Tree Selected',
          subtitle: 'Go to Home and create a family tree first.',
        ),
      );
    }

    final treeAsync = ref.watch(currentTreeProvider);
    final graphAsync = ref.watch(
      treeGraphDataProvider(TreeGraphParams(
        treeId,
        treeAsync.value?.rootPersonId,
      )),
    );

    return Scaffold(
      backgroundColor: cs.surfaceContainerLowest,
      appBar: AppBar(
        title: treeAsync.when(
          data: (t) => Text(t?.name ?? 'Family Tree'),
          loading: () => const Text('Family Tree'),
          error: (_, __) => const Text('Family Tree'),
        ),
        backgroundColor: cs.surface,
        actions: [
          IconButton(
            icon: const Icon(Icons.people_outlined),
            tooltip: 'View all members',
            onPressed: () => context.go('/members'),
          ),
        ],
      ),
      body: graphAsync.when(
        data: (graphData) {
          final anchorId = treeAsync.value?.rootPersonId ??
              (graphData.persons.isNotEmpty
                  ? graphData.persons.first.id
                  : null);

          final layout = _layoutAlgo.compute(graphData, anchorId);

          if (layout.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.account_tree_outlined,
              title: 'Tree is Empty',
              subtitle: 'Add family members to start building your tree.',
              actionLabel: 'Add Member',
              onAction: () => context.push('/member/add',
                  extra: {'treeId': treeId}),
            );
          }

          // Auto-center on first build
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_transformCtrl.value == Matrix4.identity()) {
              _centerView(layout);
            }
          });

          return Stack(
            children: [
              // ── Interactive Tree Canvas ──────────────────────────────
              InteractiveViewer(
                transformationController: _transformCtrl,
                boundaryMargin: const EdgeInsets.all(500),
                minScale: 0.05,
                maxScale: 3.0,
                child: TreeCanvas(
                  layout: layout,
                  onNodeTap: (person) =>
                      context.push('/member/${person.id}'),
                ),
              ),

              // ── Floating Controls ────────────────────────────────────
              Positioned(
                right: 16,
                bottom: 24,
                child: _FloatingControls(
                  onZoomIn: _zoomIn,
                  onZoomOut: _zoomOut,
                  onCenter: () => _centerView(layout),
                ),
              ),

              // ── Legend ───────────────────────────────────────────────
              Positioned(
                left: 16,
                bottom: 24,
                child: _Legend(),
              ),
            ],
          );
        },
        loading: () => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text('Building your family tree…',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: cs.onSurfaceVariant)),
            ],
          ),
        ),
        error: (e, _) => AppErrorWidget(error: e),
      ),
    );
  }
}

// ─── Floating Controls ────────────────────────────────────────────────────────

class _FloatingControls extends StatelessWidget {
  const _FloatingControls({
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onCenter,
  });
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onCenter;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ControlButton(icon: Icons.add, onTap: onZoomIn),
        const SizedBox(height: 8),
        _ControlButton(icon: Icons.remove, onTap: onZoomOut),
        const SizedBox(height: 8),
        _ControlButton(icon: Icons.center_focus_strong, onTap: onCenter),
      ],
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: cs.surface,
      borderRadius: BorderRadius.circular(12),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, size: 20, color: cs.onSurface),
        ),
      ),
    );
  }
}

// ─── Legend ───────────────────────────────────────────────────────────────────

class _Legend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: cs.surface.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _LegendItem(color: cs.primary, label: 'Male'),
          const SizedBox(height: 4),
          _LegendItem(color: cs.secondary, label: 'Female'),
          const SizedBox(height: 4),
          _LegendItem(color: cs.tertiary, label: 'Other'),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label,
            style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
