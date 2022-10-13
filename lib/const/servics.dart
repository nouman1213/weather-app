import 'package:weather_app/const/const.dart';
import 'package:weather_app/model/weather_model.dart';

import 'package:http/http.dart' as http;

import '../model/hourly_weather_model.dart';

Future getCurrentWeather(lat, long) async {
  var link =
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric";
  var res = await http.get(Uri.parse(link));
  if (res.statusCode == 200) {
    var data = currentWeatherDataFromJson(res.body.toString());
    print(data);

    return data;
  }
}

getHourlyWeather(lat, long) async {
  var link =
      "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=$apiKey&units=metric";
  var res = await http.get(Uri.parse(link));
  if (res.statusCode == 200) {
    var data = hourlyWeatherDataFromJson(res.body.toString());

    return data;
  }
}
