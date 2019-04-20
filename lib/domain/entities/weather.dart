import 'package:hnh/domain/utils/utils.dart';

class Weather {
  final double temperature;
  final double minTemperature;
  final double maxTemperature;
  final int humidity;
  final int pressure;
  final double windSpeed;
  final int windDegrees;

  Weather(this.temperature, this.minTemperature, this.maxTemperature,
      this.humidity, this.pressure, this.windSpeed, this.windDegrees);

  Weather.fromMap(Map<String, dynamic> map)
      : temperature = Utils.kelvinToFah(map['main']['temp']),
        minTemperature = Utils.kelvinToFah(map['main']['temp_min']),
        maxTemperature = Utils.kelvinToFah(map['main']['temp_max']),
        humidity = map['main']['humidity'],
        pressure = map['main']['pressure'].toInt(),
        windSpeed = map['wind']['speed'],
        windDegrees = map['wind']['deg'].toInt();

  Weather.empty()
      : temperature = 0,
        minTemperature = 0,
        maxTemperature = 0,
        humidity = 0,
        pressure = 0,
        windSpeed = 0,
        windDegrees = 0;
}
