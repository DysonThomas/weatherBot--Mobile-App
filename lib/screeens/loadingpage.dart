import 'package:flutter/material.dart';
import 'package:forecast/screeens/locationscreen.dart';
import 'package:forecast/services/location.dart';
import 'package:forecast/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  double cLat = 0;
  double cLong = 0;
  static const apiKey = '6ca8fdf41d0eb64bb331d1fd4de96492';
  @override
  void initState() {
    getLoc();
    // TODO: implement initState
    super.initState();
  }

  void getLoc() async {
    Location loc = Location();
    await loc.getCurrentLocation();
    cLat = loc.latitude;
    cLong = loc.longitude;
    NetworkHelper ntw = NetworkHelper(
        url:
            'https://api.openweathermap.org/data/2.5/weather?lat=${cLat}&lon=${cLong}&appid=$apiKey&units=metric');
    var weatherDetails = await ntw.getweather();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        weatherData: weatherDetails,
      );
    }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: SpinKitDoubleBounce(
          color: Colors.black26,
          size: 50.0,
        ),
      ),
    );
  }
}
