import 'package:uuid/uuid.dart';

class Utils {
  static String uuidRandom() => Uuid().v1();
}