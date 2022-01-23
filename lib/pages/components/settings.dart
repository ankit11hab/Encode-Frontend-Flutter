import 'dart:convert';

import 'package:encode2/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  bool showCircularIndicator = false;
  String time="";
  String place_name="";
  void setTime(val){
    setState(() {
      time = val;
    });
  }
  void setLocation(val) {
    setState(() {
      place_name=val;
    });
  }
  Future<void> addRoute() async {
    setState(() {
      showCircularIndicator=true;
    });
    var res = await http.post(urlF+"geo/autocomplete/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access',
        },
        body:jsonEncode(<String, String>{
          'lat': currLat,
          'lng': currLng,
          'query': place_name
        }));
    print(res.body);
    Map<dynamic,dynamic> m = json.decode(res.body);
    print(m["predictions"][0]["place_id"]);
    var res2 = await http.post("https://3a89-146-196-45-54.ngrok.io/driver/new/route/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access',
        },
        body:jsonEncode(<String, String>{
          'place_name': place_name,
          'place_id': m["predictions"][0]["place_id"],
          'expected_time': time
        }));
    print(res2.body);
    setState(() {
      showCircularIndicator=false;
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end:Alignment.centerRight, // 10% of the width, so there are ten blinds.
              colors: <Color>[
                Color(0xff001896),
                Color(0xff060049)
              ], // red to yellow
              tileMode: TileMode.clamp, // repeats the gradient over the canvas
            ),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(25, 90, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 46,
                    fontFamily: "Dongle",
                    color: Colors.white
                  )
                ),
                Transform.translate(
                  offset: Offset(0,-25),
                  child: Text(
                    "Are you a driver?",
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 30,
                        fontFamily: "Dongle"
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  "Your driver status has been verified!",
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontFamily: "Dongle",
                    fontSize: 30
                  )
                )
              ],
            )
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 70, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    child: TextField(
                      onChanged: setTime,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20,0,20,0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(width: 1),
                        ),
                        hintText: "Exp. Time",
                      ),
                    ),
                  ),
                  SizedBox(width:10),
                  Icon(
                    Icons.radio_button_checked
                  ),
                  SizedBox(width:10),
                  Container(
                    width: 150,
                    child: TextField(
                      onChanged: setLocation,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20,0,20,0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(width: 1),
                        ),
                        hintText: "Location",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Container(
                  child:
                  showCircularIndicator?
                  Container(
                    child: CircularProgressIndicator(),
                  )
                      :
                  GestureDetector(
                    onTap: addRoute,
                    child: Text(
                        "Add Route",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.blue[800]
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
      ],
    );
  }
}
