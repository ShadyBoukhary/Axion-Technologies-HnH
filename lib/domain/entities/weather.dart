import 'package:hnh/domain/utils/utils.dart';

/// Holds current weather information.
class Weather {

  /// The current temparature in `Fahrenheit`
  final double temperature;

  /// The minimum temparature of the day in `Fahrenheit`.
  final double minTemperature;

  /// The maximum temparature of the day in `Fahrenheit`.
  final double maxTemperature;

  /// The current humidity from `1` to `100`.
  final int humidity;

  /// The current pressure in `Pascal`.
  final int pressure;

  /// The current wind speed in `mph`
  final double windSpeed;

  /// The current wind direction in `degrees`.
  final int windDegrees;

  Weather(this.temperature, this.minTemperature, this.maxTemperature,
      this.humidity, this.pressure, this.windSpeed, this.windDegrees);

  Weather.fromMap(Map<String, dynamic> map)
      : temperature = Utils.kelvinToFah(map['main']['temp'].toDouble()),
        minTemperature = Utils.kelvinToFah(map['main']['temp_min'].toDouble()),
        maxTemperature = Utils.kelvinToFah(map['main']['temp_max'].toDouble()),
        humidity = map['main']['humidity'].toInt(),
        pressure = map['main']['pressure'].toInt(),
        windSpeed = map['wind']['speed'].toDouble(),
        windDegrees = map['wind']['deg'].toInt();

  /// Creates an empty [Weather] object with `0` values.
  Weather.empty()
      : temperature = 0,
        minTemperature = 0,
        maxTemperature = 0,
        humidity = 0,
        pressure = 0,
        windSpeed = 0,
        windDegrees = 0;
}
