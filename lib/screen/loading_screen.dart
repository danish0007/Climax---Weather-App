import 'package:exam2/screen/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:exam2/components/location.dart';
import 'package:exam2/components/location_permission.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  double latitude;
  double longitude;
  AnimationController controller;
  Location location = Location();
  Permission permission = Permission();
  dynamic decodeddata;

  @override
  void initState() {
    super.initState();
    callingfunctions();
  }

  void callingfunctions() async {
    decodeddata = await permission.requestpermission();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return WeatherScreen(decodeddata: this.decodeddata);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Center(
          child: SpinKitFoldingCube(
              color: Colors.tealAccent,
              size: 75,
              controller: AnimationController(
                  vsync: this, duration: const Duration(milliseconds: 750))),
        ),
      ),
    );
  }
}
