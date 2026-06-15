// lib/shared/widgets/person_avatar.dart
import 'dart:io';
import 'package:flutter/material.dart';
import '../../features/member/domain/entities/person_entity.dart';
import '../../core/constants/app_constants.dart';

class PersonAvatar extends StatelessWidget {
  const PersonAvatar({
    super.key,
    required this.person,
    this.radius = 28,
    this.showBorder = false,
  });

  final PersonEntity person;
  final double radius;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = _bgColor(context, person.gender);
    final fg = _fgColor(context, person.gender);

    Widget avatar;

    if (person.profilePhotoPath != null &&
        File(person.profilePhotoPath!).existsSync()) {
      avatar = CircleAvatar(
        radius: radius,
        backgroundImage: FileImage(File(person.profilePhotoPath!)),
        backgroundColor: bg,
      );
    } else {
      avatar = CircleAvatar(
        radius: radius,
        backgroundColor: bg,
        child: Text(
          person.initials,
          style: TextStyle(
            color: fg,
            fontSize: radius * 0.6,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    if (!person.isLiving) {
      avatar = Stack(
        children: [
          ColorFiltered(
            colorFilter: const ColorFilter.matrix([
              0.2126, 0.7152, 0.0722, 0, 0,
              0.2126, 0.7152, 0.0722, 0, 0,
              0.2126, 0.7152, 0.0722, 0, 0,
              0,      0,      0,      1, 0,
            ]),
            child: avatar,
          ),
        ],
      );
    }

    if (showBorder) {
      avatar = Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: cs.outline, width: 2),
        ),
        child: avatar,
      );
    }

    return avatar;
  }

  Color _bgColor(BuildContext context, Gender gender) {
    final cs = Theme.of(context).colorScheme;
    switch (gender) {
      case Gender.male:
        return cs.primaryContainer;
      case Gender.female:
        return cs.secondaryContainer;
      default:
        return cs.tertiaryContainer;
    }
  }

  Color _fgColor(BuildContext context, Gender gender) {
    final cs = Theme.of(context).colorScheme;
    switch (gender) {
      case Gender.male:
        return cs.onPrimaryContainer;
      case Gender.female:
        return cs.onSecondaryContainer;
      default:
        return cs.onTertiaryContainer;
    }
  }
}

// ─── Small inline gender indicator dot ────────────────────────────────────────

class GenderDot extends StatelessWidget {
  const GenderDot({super.key, required this.gender});
  final Gender gender;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = switch (gender) {
      Gender.male => cs.primary,
      Gender.female => cs.secondary,
      _ => cs.tertiary,
    };
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
