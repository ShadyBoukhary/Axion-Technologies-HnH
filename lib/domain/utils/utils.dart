import 'package:uuid/uuid.dart';

class Utils {
  static String uuidRandom() => Uuid().v1();
  static String get currentYear => DateTime.now().year.toString();
}