import 'package:hnh/domain/entities/coordinates.dart';
import 'package:hnh/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather(Coordinates coordinates);
}