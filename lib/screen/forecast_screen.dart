import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:exam2/widgets/tile.dart';

List<String> forecastdates = [];
List<double> mintemp = [];
List<double> maxtemp = [];
List<int> Pressure = [];
List<int> Humdity = [];
List<double> Wind = [];
List<double> Rain = [];
List<String> Logos = [];

class ForecastScreen extends StatefulWidget {
  String location;
  var decodeddata;
  ForecastScreen(this.decodeddata, this.location);

  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  var decoded;
  double min, max, wind, rain;
  String icon;
  int pressure, humidity;

  // functions to fill the lists are below
  void filldailydate() {
    for (int i = 0; i < (decoded['daily'].length); i++) {
      int timeInMillis = decoded['daily'][i]['dt'];
      var dates = DateTime.fromMillisecondsSinceEpoch(timeInMillis * 1000);
      var formattedDate = DateFormat.yMMMd().format(dates);
      forecastdates.add(formattedDate);
    }
  }

  void filldailymin() {
    for (int i = 0; i < (decoded['daily'].length); i++) {
      min = decoded['daily'][i]['temp']['min'];
      mintemp.add(min);
    }
  }

  void filldailyicon() {
    for (int i = 0; i < (decoded['daily'].length); i++) {
      icon = decoded['daily'][i]['weather'][0]['icon'];
      Logos.add(icon);
    }
  }

  void filldailymax() {
    for (int i = 0; i < (decoded['daily'].length); i++) {
      max = decoded['daily'][i]['temp']['max'];
      maxtemp.add(max);
    }
  }

  void filldailypressure() {
    for (int i = 0; i < (decoded['daily'].length); i++) {
      pressure = decoded['daily'][i]['pressure'];
      Pressure.add(pressure);
    }
  }

  void filldailyhumidity() {
    for (int i = 0; i < (decoded['daily'].length); i++) {
      humidity = decoded['daily'][i]['humidity'];
      Humdity.add(humidity);
    }
  }

  void filldailyrain() {
    for (int i = 0; i < (decoded['daily'].length); i++) {
      rain = decoded['daily'][i]['rain'];
      rain = (rain == null) ? 0 : rain;
      Rain.add(rain);
    }
  }

  void filldailywind() {
    for (int i = 0; i < (decoded['daily'].length); i++) {
      wind = decoded['daily'][i]['wind_speed'];
      Wind.add(wind);
    }
  }

  @override
  void initState() {
    super.initState();
    decoded = widget.decodeddata;
    filldailydate();
    filldailymin();
    filldailymax();
    filldailyhumidity();
    filldailypressure();
    filldailyrain();
    filldailywind();
    filldailyicon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromRGBO(35, 49, 95, 1),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            '${widget.location}',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(235, 246, 245, 0.6),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Next 7 Days',
                      style: TextStyle(
                        color: Color.fromRGBO(35, 49, 95, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            color: Colors.grey,
                            child: Image(
                              fit: BoxFit.contain,
                              image: AssetImage('Icons/${Logos[0]}.png'),
                            ),
                          ),
                          SizedBox(width: 15),
                          Text(
                            '${forecastdates[0]}',
                            style: TextStyle(
                              color: Color.fromRGBO(35, 49, 95, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(width: 60),
                          Text(
                            '${maxtemp[0].toInt()}°',
                            style: TextStyle(
                              color: Color.fromRGBO(35, 49, 95, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '${mintemp[0].toInt()}°',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(35, 49, 95, 0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(height: 20),
                    Tile(
                      title: ['Precipitation', 'Wind'],
                      value: ['${Rain[0]}%', '${Wind[0]} km/h'],
                    ),
                    SizedBox(height: 20),
                    Tile(
                      title: ['Humidity', 'Pressure'],
                      value: ['${Humdity[0]}%', '${Pressure[0]} hpa'],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              ListTile(1),
              ListTile(2),
              ListTile(3),
              ListTile(4),
              ListTile(5),
              ListTile(6),
            ],
          ),
        ),
      ),
    );
  }
}

class ListTile extends StatelessWidget {
  int index;
  ListTile(this.index);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 1),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 15),
        color: Colors.white,
        child: Row(
          children: [
            Container(
              height: 20,
              width: 20,
              color: Colors.grey,
              child: Image(
                fit: BoxFit.contain,
                image: AssetImage('Icons/${Logos[index]}.png'),
              ),
            ),
            SizedBox(width: 10),
            Text(
              '${forecastdates[index]}',
              style: TextStyle(
                  color: Color.fromRGBO(35, 49, 95, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            SizedBox(
              width: 60,
            ),
            Row(
              children: [
                Text(
                  '${(maxtemp[index]).toInt()}°',
                  style: TextStyle(
                    color: Color.fromRGBO(35, 49, 95, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '${(mintemp[index]).toInt()}°',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(35, 49, 95, 0.8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
