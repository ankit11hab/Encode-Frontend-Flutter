import 'dart:convert';

import 'package:encode2/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({Key? key}) : super(key: key);

  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  @override
  var locationMessage = "";

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(15)
        ),
        margin: EdgeInsets.fromLTRB(0, 10, 0, 3),
        width: MediaQuery.of(context).size.width-10,
        child: Row(
          children: [
            Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            currLocation1
                          )
                        ],
                      )
                  ),


            Spacer(),
            Icon(
              Icons.location_on,
              color: Colors.blue,
              size: 40,
            )
          ],
        )
    );
  }
}
