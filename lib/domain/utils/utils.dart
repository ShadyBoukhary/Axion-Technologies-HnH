import 'package:uuid/uuid.dart';

class Utils {
  static String uuidRandom() => Uuid().v1();
  static String get currentYear => DateTime.now().year.toString();
  static String get newTimestamp => (DateTime.now().millisecondsSinceEpoch / 1000).floor().toString();
  static double kelvinToFah(double kelvin) => 9/5 * (kelvin - 273.15) + 32;
  
}