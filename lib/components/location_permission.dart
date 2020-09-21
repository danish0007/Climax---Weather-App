import 'package:geolocator/geolocator.dart';
import 'location.dart';

class Permission {
  Location location = Location();

  Future<dynamic> requestpermission() async {
    await requestPermission();
    bool islocationserviceenabled = await isLocationServiceEnabled();
    if (islocationserviceenabled) {
      var data = await location.getlocation();
      return data;
    } else {
      print("Permssion Denied");
    }
  }
}
