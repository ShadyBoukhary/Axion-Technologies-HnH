import 'package:hnh/domain/repositories/location_repository.dart';
import 'package:hnh/domain/entities/location.dart';
import 'dart:async';
import 'package:location/location.dart' as LocationLib;

class DeviceLocationRepository implements LocationRepository {
  //This class is a "singleton", it will only be instantiated once (the _instance)
  static final DeviceLocationRepository _instance = DeviceLocationRepository._internal();
  DeviceLocationRepository._internal();
  factory DeviceLocationRepository() => _instance;

  /// getLocation
  /// Gets the current location of the device in the format of Location entity
  /// Returns: A Future<Location> object or null upon failure.
  Future<Location> getLocation() async{
    //Instantiate the library's class
    LocationLib.Location location_getter = new LocationLib.Location();
    //This is the location as the library returns it, a map of string,double
    Map location = <String, double>{};
    //This is the format we will need the location in when we return it
    Location result;
    try {
      location = await location_getter.getLocation();
      result = new Location(location['latitude'], location['longitude'], (new DateTime.now().millisecondsSinceEpoch / 1000).toString());
      return result;
    }catch(e){
      location = null;
      return null;
    }
  }

}
