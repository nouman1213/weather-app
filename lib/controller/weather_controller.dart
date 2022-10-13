import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/const/const.dart';
import 'package:weather_app/const/servics.dart';

class WeatherController extends GetxController {
  // create various variables
  final RxDouble lattitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;

  final RxBool isloaded = false.obs;

  var weaterData;
  var HourlyWeatherData;
  @override
  void onInit() async {
    await getUserLocation();
    weaterData = getCurrentWeather(lattitude.value, longitude.value);
    HourlyWeatherData = getHourlyWeather(latitude, longitude);
    super.onInit();
  }

  getUserLocation() async {
    bool isLocationEnabled;
    LocationPermission userPermission;

    isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      return Future.error("Location is not enabled");
    }

    userPermission = await Geolocator.checkPermission();
    if (userPermission == LocationPermission.deniedForever) {
      return Future.error("Permission is denied forever");
    } else if (userPermission == LocationPermission.denied) {
      userPermission = await Geolocator.requestPermission();
      if (userPermission == LocationPermission.denied) {
        return Future.error("Permission is denied");
      }
    }

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      lattitude.value = value.latitude;
      longitude.value = value.longitude;
      isloaded.value = true;
    });
  }
}
