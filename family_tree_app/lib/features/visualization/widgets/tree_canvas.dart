// lib/features/visualization/widgets/tree_canvas.dart
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../member/domain/entities/person_entity.dart';
import '../models/tree_node_model.dart';

class TreeCanvas extends StatelessWidget {
  const TreeCanvas({super.key, required this.layout, this.onNodeTap});
  final TreeLayoutResult layout;
  final void Function(PersonEntity)? onNodeTap;

  @override
  Widget build(BuildContext context) {
    if (layout.isEmpty) return const SizedBox();

    return SizedBox(
      width: layout.canvasWidth,
      height: layout.canvasHeight,
      child: Stack(
        children: [
          // ── Connection lines (drawn underneath nodes) ─────────────────
          Positioned.fill(
            child: CustomPaint(
              painter: _TreeLinePainter(
                nodes: layout.nodes,
                edges: layout.edges,
                lineColor: Theme.of(context).colorScheme.outlineVariant,
                spouseLineColor: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),

          // ── Person node cards ─────────────────────────────────────────
          ...layout.nodes.values.map(
            (node) => Positioned(
              left: node.x,
              top: node.y,
              child: _PersonNodeCard(
                node: node,
                onTap: onNodeTap != null
                    ? () => onNodeTap!(node.person)
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Line Painter ─────────────────────────────────────────────────────────────

class _TreeLinePainter extends CustomPainter {
  _TreeLinePainter({
    required this.nodes,
    required this.edges,
    required this.lineColor,
    required this.spouseLineColor,
  });

  final Map<String, TreeNode> nodes;
  final List<TreeEdge> edges;
  final Color lineColor;
  final Color spouseLineColor;

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final spousePaint = Paint()
      ..color = spouseLineColor.withOpacity(0.6)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (final edge in edges) {
      final from = nodes[edge.fromId];
      final to = nodes[edge.toId];
      if (from == null || to == null) continue;

      if (edge.type == EdgeType.spouse) {
        _drawSpouseLine(canvas, spousePaint, from, to);
      } else {
        _drawParentChildLine(canvas, linePaint, from, to);
      }
    }
  }

  void _drawSpouseLine(
      Canvas canvas, Paint paint, TreeNode from, TreeNode to) {
    // Simple horizontal dashed-ish line between spouse centers
    final leftNode = from.x < to.x ? from : to;
    final rightNode = from.x < to.x ? to : from;

    final startX = leftNode.x + TreeNode.nodeWidth;
    final endX = rightNode.x;
    final y = leftNode.y + TreeNode.nodeHeight / 2;

    canvas.drawLine(Offset(startX, y), Offset(endX, y), paint);
  }

  void _drawParentChildLine(
      Canvas canvas, Paint paint, TreeNode parent, TreeNode child) {
    // Bezier curve: parent bottom-center → child top-center
    final startX = parent.x + TreeNode.nodeWidth / 2;
    final startY = parent.y + TreeNode.nodeHeight;
    final endX = child.x + TreeNode.nodeWidth / 2;
    final endY = child.y;

    final midY = (startY + endY) / 2;

    final path = Path()
      ..moveTo(startX, startY)
      ..cubicTo(startX, midY, endX, midY, endX, endY);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_TreeLinePainter oldDelegate) =>
      oldDelegate.nodes != nodes || oldDelegate.edges != edges;
}

// ─── Person Node Card ─────────────────────────────────────────────────────────

class _PersonNodeCard extends StatelessWidget {
  const _PersonNodeCard({required this.node, this.onTap});
  final TreeNode node;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final person = node.person;

    final bgColor = person.isLiving
        ? cs.surfaceContainerLow
        : cs.surfaceContainerHighest.withOpacity(0.8);

    final borderColor = _borderColor(cs, person);

    return SizedBox(
      width: TreeNode.nodeWidth,
      height: TreeNode.nodeHeight,
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        shadowColor: cs.shadow.withOpacity(0.15),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor, width: 1.5),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Photo / avatar
                _NodeAvatar(person: person, radius: 18),
                const SizedBox(height: 4),
                // Name
                Text(
                  person.shortName,
                  style: tt.labelSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    color: person.isLiving
                        ? cs.onSurface
                        : cs.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                // Lifespan
                if (person.birthYear != null)
                  Text(
                    person.lifespan,
                    style: tt.labelSmall?.copyWith(
                      fontSize: 9,
                      color: cs.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _borderColor(ColorScheme cs, PersonEntity person) {
    return switch (person.gender) {
      Gender.male   => cs.primary.withOpacity(0.5),
      Gender.female => cs.secondary.withOpacity(0.5),
      _             => cs.outlineVariant,
    };
  }
}

class _NodeAvatar extends StatelessWidget {
  const _NodeAvatar({required this.person, required this.radius});
  final PersonEntity person;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final hasPhoto = person.profilePhotoPath != null &&
        File(person.profilePhotoPath!).existsSync();

    final bg = switch (person.gender) {
      Gender.male => cs.primaryContainer,
      Gender.female => cs.secondaryContainer,
      _ => cs.tertiaryContainer,
    };

    if (hasPhoto) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: FileImage(File(person.profilePhotoPath!)),
        backgroundColor: bg,
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: bg,
      child: Text(
        person.initials,
        style: TextStyle(
          fontSize: radius * 0.65,
          fontWeight: FontWeight.w700,
          color: cs.onPrimaryContainer,
        ),
      ),
    );
  }
}
