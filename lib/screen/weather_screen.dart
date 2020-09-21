import 'package:exam2/screen/forecast_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:exam2/components/time_stamp.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:exam2/widgets/subtitle.dart';

List<double> hourlydata = [];
List<String> hourlytime = [];
List<String> hourlyicon = [];

class WeatherScreen extends StatefulWidget {
  var decodeddata;
  WeatherScreen({this.decodeddata});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var decoded;
  var current_day;
  TimeStamp timeStamp = TimeStamp();

  // variables declaration
  double temp, realfeel, windspeed; // uvi stands for UV Index.
  String formatted, description, currentcountry, icon;
  int pressure, humidity, visibility, time, formatted_temp;
  String formatted_time;

  void fillhourlydata() {
    try {
      for (int i = 0; i <= 20; i = i + 4) {
        double d = decoded['hourly'][i]['temp'];
        double data = (d is double) ? d : d.toDouble();
        hourlydata.add(data);
      }
    } catch (e) {
      print(e);
    }
  }

  void fillhourlytime() {
    for (int i = 0; i <= 20; i = i + 4) {
      int time = decoded['hourly'][i]['dt'];
      String format_time = timeStamp.readTimestamp(time);
      hourlytime.add(format_time);
    }
  }

  void fillhourlyicon() {
    for (int i = 0; i <= 20; i = i + 4) {
      String icon = decoded['hourly'][i]['weather'][0]['icon'];
      hourlyicon.add(icon);
    }
  }

  @override
  void initState() {
    super.initState();
    decoded = widget.decodeddata;
    updateUI(decoded);
    fillhourlydata();
    fillhourlytime();
    fillhourlyicon();
  }

  // to format time zone
  String stringformating(String raw) {
    int index = raw.indexOf('/');
    String country = raw.substring(0, index);
    String city = raw.substring(index + 1);
    String formatted = country + ',  ' + city;
    return formatted;
  }

  // updates the ui of app
  void updateUI(var decode) {
    if (decode != null) {
      setState(() {
        var currDt = DateTime.now();
        current_day = DateFormat('EEEEE', 'en_US').format(
            currDt); // used for getting the current day in english eg: Thursday
        currentcountry = decoded['timezone'];
        formatted = stringformating(currentcountry);
        description = decoded['current']['weather'][0]['description'];
        temp = decode['current']['temp'];
        formatted_temp = temp.ceil();
        icon = decode['current']['weather'][0]['icon'];
        realfeel = decode['current']['feels_like'];
        pressure = decode['current']['pressure'];
        humidity = decode['current']['humidity'];
        visibility = decode['current']['visibility'];
        windspeed = decode['current']['wind_speed'];
        time = decode['current']['dt'];
        formatted_time = timeStamp.readTimestamp(time);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            //gradient for background
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.lightBlueAccent, Colors.teal],
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '$formatted',
                            style: GoogleFonts.ebGaramond(
                                fontSize: 36, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                '$current_day,',
                                style: GoogleFonts.roboto(
                                  fontSize: 22,
                                  color: Colors.grey[900],
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                '$formatted_time',
                                style: GoogleFonts.openSans(
                                  fontSize: 22,
                                  color: Colors.grey[900],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.short_text,
                          color: Colors.grey[900],
                          size: 35,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ForecastScreen(decoded, formatted),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //used for image which show the current weather
              Container(
                height: 100,
                width: 300,
                child: Image(
                  fit: BoxFit.fitHeight,
                  image: AssetImage('Icons/$icon.png'),
                  height: 500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        '$formatted_temp°',
                        style: TextStyle(fontSize: 65),
                      ),
                    ),
                    Text(
                      '$description',
                      style: GoogleFonts.openSans(
                          fontSize: 25, color: Colors.grey[800]),
                    ),
                    Text(
                      'Feels Like $realfeel',
                      style: TextStyle(color: Colors.grey[800], fontSize: 22),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Divider(
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SubTitle(name: 'Pressure', value: '$pressure mb'),
                              SubTitle(
                                  name: 'Visibility',
                                  value: '${(visibility / 1000).toInt()} Km'),
                              SubTitle(name: 'Humidity', value: '$humidity %'),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Sparkline(
                            data: hourlydata,
                            sharpCorners: true,
                            pointsMode: PointsMode.all,
                            pointSize: 12,
                            lineWidth: 3,
                            pointColor: Colors.lightGreenAccent,
                            lineColor: Colors.cyanAccent,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TimeTemp(0),
                            TimeTemp(1),
                            TimeTemp(2),
                            TimeTemp(3),
                            TimeTemp(4),
                            TimeTemp(5),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeTemp extends StatelessWidget {
  TimeTemp(this.index);
  int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          '${hourlydata[index].ceil()}°',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '${hourlytime[index].substring(0, 5)}',
          style: TextStyle(
              color: Color.fromRGBO(225, 225, 225, 0.8), fontSize: 18),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 33,
          width: 35,
          child: Image(
            fit: BoxFit.fill,
            image: AssetImage('Icons/${hourlyicon[index]}.png'),
          ),
        ),
      ],
    );
  }
}
