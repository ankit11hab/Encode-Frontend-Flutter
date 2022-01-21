import 'dart:convert';

import 'package:encode2/pages/components/explore.dart';
import 'package:encode2/pages/components/settings.dart';
import 'package:encode2/pages/loadingscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:encode2/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  late final Future myFuture= getData();
  Future<int> getData() async {
    var res1 = await http.post("https://a4d0-146-196-45-54.ngrok.io/auth/get_profile/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access',
        });
    if(res1.statusCode==200) {
      Map<dynamic,dynamic> m = jsonDecode(res1.body);
      setState(() {
        username=m['username'];
        first_name=m['first_name'];
        last_name=m['last_name'];
        email=m['email'];
      });
    }
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);
    setState(() {
      currLat = position.latitude.toString();
      currLng = position.longitude.toString();
    });
    var res2 = await http.post("https://a4d0-146-196-45-54.ngrok.io/geo/decode_latlang/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access',
        },
        body:jsonEncode(<String, String>{
          'lat': position.latitude.toString(),
          'lng':position.longitude.toString(),
        }));
    if(res2.statusCode==200){
      Map<dynamic,dynamic> m = jsonDecode(res2.body);
      setState(() {
        currLocation1=m['plus_code']['compound_code'];
      });
    }
    var res3 = await http.post("https://a4d0-146-196-45-54.ngrok.io/passenger/history/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access',
        });
    if(res3.statusCode==200){
      Map<dynamic,dynamic> m = jsonDecode(res3.body);
      setState(() {
        travelHistory = m;
      });
    }
    var res4 = await http.post("https://a4d0-146-196-45-54.ngrok.io/passenger/active/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access',
        });
    print(res4.body);
    if(res4.statusCode==200){
      Map<dynamic,dynamic> m = jsonDecode(res4.body);
      setState(() {
        activeBookings = m;
      });
    }
    return 1;
  }

  int _currentIndex = 0;
  final _tabs = [
    Explore(),
    Settings()
  ];


  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context,snapshot) {
        if(!snapshot.hasData) {
          return LoadingScreen();
        }
        else if(snapshot.hasData) {
          return Scaffold(
            body:_tabs[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex:_currentIndex,
              unselectedFontSize: 14,
              selectedFontSize: 14,
              items:[
                BottomNavigationBarItem(
                    icon: Icon(Icons.location_on_outlined),
                    title: Text("Explore")
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    title: Text("Settings")
                ),
              ],
              onTap: (index){
                setState(() {
                  _currentIndex=index;
                });
              },
            ),
          );
        }

        else {
          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "Oops! There has been some error!",
                      style: TextStyle(
                        fontSize: 20,
                      )
                  )
                ],
              )
          );

        }
      },
      future: myFuture,
    );

  }
}
