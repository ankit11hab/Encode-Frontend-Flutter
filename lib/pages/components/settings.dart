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

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 70, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          SizedBox(height: 20),
          Container(
              child: GestureDetector(
                onTap: (){},
                child: Text(
                    "Profile",
                  style: TextStyle(
                      fontSize: 19,
                    fontWeight: FontWeight.w500
                  ),
                ),
              )
          ),
          Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                                first_name,
                                style: TextStyle(
                                  fontSize: 17,
                                )
                            ),
                            SizedBox(width: 6),
                            Text(
                                last_name,
                                style: TextStyle(
                                  fontSize: 17,
                                )
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                                "Username:  ",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500
                                )
                            ),
                            Text(
                              username,
                              style: TextStyle(
                                fontSize: 17,
                              )
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                                "Email:  ",
                                style: TextStyle(
                                    fontSize: 17,
                                  fontWeight: FontWeight.w500
                                )
                            ),
                            Text(
                              email,
                              style: TextStyle(
                                fontSize: 17
                              )
                            ),

                          ],
                        )
                      ],
                    )
                ),



          SizedBox(height: 20),
          Container(
              child: GestureDetector(
                onTap: (){},
                child: Text(
                  "Driver mode",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black45
                  ),
                ),
              )
          ),
          SizedBox(height: 5),
          Container(
              child: GestureDetector(
                onTap: ()async{
                  late SharedPreferences prefs;
                  prefs = await SharedPreferences.getInstance();
                  prefs.setString("accessPref","");
                  prefs.setString("refreshPref","");
                  setState(() {
                    access="";
                    refresh="";
                  });
                  Navigator.of(context).pushNamed('/loginOptions');
                },
                child: Text(
                    "Logout",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black45
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}
