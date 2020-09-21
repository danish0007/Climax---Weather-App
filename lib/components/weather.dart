import 'dart:convert';
import 'package:http/http.dart' as http;

const String ApiKey = '3514bbd3b3dcd18ff4f1deace847715e';

class Weather {
  Future<dynamic> getcurrentWeather(double lat, double lon) async {
    try {
      http.Response response = await http.get(
          'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&%20&appid=$ApiKey&units=metric');

      var data = jsonDecode(response.body);
      return data;
    } catch (e) {
      print(e);
    }
  }
}
