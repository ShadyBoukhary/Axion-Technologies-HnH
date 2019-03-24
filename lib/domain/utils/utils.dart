import 'package:uuid/uuid.dart';

class Utils {
  static String uuidRandom() => Uuid().v1();
  static String get currentYear => DateTime.now().year.toString();
  static String get newTimestamp => (DateTime.now().millisecondsSinceEpoch / 1000).floor().toString();
}