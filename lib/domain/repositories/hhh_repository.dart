import 'package:hnh/domain/entities/hhh.dart';
import 'dart:async';

abstract class HHHRepository {
  Future<List<HHH>> getAllHHHs();
  Future<HHH> getCurrentHHH();
}