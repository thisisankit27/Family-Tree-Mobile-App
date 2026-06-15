// lib/core/utils/uuid_util.dart
import 'package:uuid/uuid.dart';

class UuidUtil {
  UuidUtil._();
  static const _uuid = Uuid();
  static String generate() => _uuid.v4();
}
