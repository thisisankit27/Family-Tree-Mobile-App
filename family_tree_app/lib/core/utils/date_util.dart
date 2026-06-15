// lib/core/utils/date_util.dart
import 'package:intl/intl.dart';

class DateUtil {
  DateUtil._();

  static final _displayFormat = DateFormat('MMM d, yyyy');
  static final _isoFormat = DateFormat('yyyy-MM-dd');

  /// Format ISO date string (YYYY-MM-DD) for display.
  static String formatDisplay(String? isoDate, {bool approx = false}) {
    if (isoDate == null || isoDate.isEmpty) return 'Unknown';
    try {
      // Handle partial dates like "1940" or "1940-06"
      if (isoDate.length == 4) {
        return approx ? 'circa $isoDate' : isoDate;
      }
      if (isoDate.length == 7) {
        final d = DateFormat('yyyy-MM').parse(isoDate);
        return approx ? 'circa ${DateFormat('MMM yyyy').format(d)}' : DateFormat('MMM yyyy').format(d);
      }
      final d = _isoFormat.parse(isoDate);
      return approx ? 'circa ${_displayFormat.format(d)}' : _displayFormat.format(d);
    } catch (_) {
      return isoDate;
    }
  }

  /// Extract year integer from ISO date string.
  static int? extractYear(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) return null;
    return int.tryParse(isoDate.split('-').first);
  }

  /// Convert DateTime to ISO date string.
  static String toIso(DateTime date) => _isoFormat.format(date);

  /// Today's ISO date string.
  static String today() => toIso(DateTime.now());

  /// Build a lifespan string like "1940 – 2005" or "1975 –".
  static String lifespan(String? birthDate, String? deathDate, bool isLiving) {
    final birth = extractYear(birthDate)?.toString() ?? '?';
    if (isLiving) return '$birth –';
    final death = extractYear(deathDate)?.toString() ?? '?';
    return '$birth – $death';
  }

  /// Calculate age from birth date.
  static int? calculateAge(String? birthDate, String? deathDate) {
    if (birthDate == null) return null;
    try {
      final birth = _isoFormat.parse(birthDate.length >= 10 ? birthDate : '$birthDate-01-01');
      final reference = deathDate != null
          ? _isoFormat.parse(deathDate.length >= 10 ? deathDate : '$deathDate-01-01')
          : DateTime.now();
      int age = reference.year - birth.year;
      if (reference.month < birth.month ||
          (reference.month == birth.month && reference.day < birth.day)) {
        age--;
      }
      return age >= 0 ? age : null;
    } catch (_) {
      return null;
    }
  }
}
