// Shady Boukhary

import 'package:hnh/domain/entities/sponsor.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

/// Handles data retrieval for [Sponsor]s.
abstract class SponsorRepository {

  /// Retrieves a list of [Sponsor] for a give [year].
  Future<List<Sponsor>> getSponsors({@required String year});

  /// Retrieves a list of sponsors for the current year.
  Future<List<Sponsor>> getCurrentSponsors();

}