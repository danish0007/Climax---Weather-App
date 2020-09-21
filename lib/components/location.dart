import 'package:geolocator/geolocator.dart';
import 'weather.dart';

class Location {
  Weather weather = Weather();

  Future<dynamic> getlocation() async {
    try {
      Position position =
          await getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
      var data = await weather.getcurrentWeather(
          position.latitude, position.longitude);
      return data;
    } catch (e) {
      print(e);
    }
  }
}
