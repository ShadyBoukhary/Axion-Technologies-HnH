// Shady Boukhary

import 'package:hnh/domain/entities/hhh.dart';
import 'dart:async';

/// Handles data retrieal for yearly [HHHH]
abstract class HHHRepository {

  /// Retrieves all [HHH]s throughout the years
  Future<List<HHH>> getAllHHHs();

  /// Retrieves this year's [HHH].
  Future<HHH> getCurrentHHH();
}