import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherData});
  final weatherData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  int temp = 0;
  String description = "";
  String city = "";
  int condition = 0;
  int mainImgIndex = 1;
  String Searchedcity = "";
  static const apiKey = 'MapKey';
  void initState() {
    updateUi(widget.weatherData);
    // TODO: implement initState
    super.initState();
  }

  void updateUi(element) {
    double temprature = element['main']['temp'];
    temp = temprature.toInt();
    city = element['name'];
    condition = element['weather'][0]['id'];
    description = element['weather'][0]['description'];
    findImage();
  }

  findImage() {
    if (condition < 300) {
      mainImgIndex = 1;
    } else if (condition < 400) {
      mainImgIndex = 1;
    } else if (condition < 600) {
      mainImgIndex = 2;
    } else if (condition < 700) {
      mainImgIndex = 2;
    } else if (condition < 800) {
      mainImgIndex = 3;
    } else if (condition == 800) {
      mainImgIndex = 3;
    } else if (condition <= 804) {
      mainImgIndex = 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.65;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xff00e676),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              const SizedBox(
                width: 500,
                height: 252.5,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xff00e676),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                      bottomRight: Radius.circular(70),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      '${temp.toString()}°C ',
                      style: TextStyle(
                        fontSize: 90,
                        color: Colors.white,
                        fontFamily: 'Spartan MB',
                      ),
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Spartan MB',
                        // fontStyle: FontStyle.italic
                      ),
                      children: [
                        WidgetSpan(
                            child: Icon(
                          Icons.location_on_sharp,
                          color: Colors.white,
                        )),
                        TextSpan(text: city),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Spartan MB',
                        // fontStyle: FontStyle.italic,
                      ),
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.beach_access,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(text: description),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 220),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextField(
                    style: TextStyle(
                      fontFamily: 'Spartan MB',
                    ),
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.location_city),
                        suffixIcon: Icon(Icons.search),
                        hoverColor: Colors.black26,
                        focusColor: Colors.black26,
                        filled: true,
                        hintText: 'Enter City Name',
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onSubmitted: (value) async {
                      var url =
                          'http://api.openweathermap.org/data/2.5/weather?q=$value&mode=json&appid=$apiKey&units=metric';
                      http.Response resp = await http.get(Uri.parse(url));
                      var json = jsonDecode(resp.body);
                      double temprature = json['main']['temp'];
                      temp = temprature.toInt();
                      city = json['name'];
                      condition = json['weather'][0]['id'];
                      description = json['weather'][0]['description'];
                      findImage();
                    },
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Image.asset('images/weather${mainImgIndex}.png'),
          )
        ],
      ),
    );
  }
}
