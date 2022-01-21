import 'dart:convert';

import 'package:encode2/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FindBuses extends StatefulWidget {
  final Object? place_id;
  const FindBuses({Key? key, required this.place_id}) : super(key: key);

  @override
  _FindBusesState createState() => _FindBusesState();
}

class _FindBusesState extends State<FindBuses> {
  @override
  late final Future myFuture= getBuses();
  List<dynamic> buses=[];
  Future<int> getBuses() async {
    var res = await http.post("https://1d64-146-196-45-54.ngrok.io/driver/get/buses/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access',
        },
        body:jsonEncode(<String, String>{
        'place_id': widget.place_id.toString(),
        }));
    print(res.body);
    Map<String,dynamic> m = jsonDecode(res.body);
    setState(() {
      buses=m['data'];
    });
    return 1;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(25,90,25,0),
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
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Available Buses",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 46,
                        fontFamily: "Dongle"
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0,-25),
                    child: Text(
                      widget.place_id.toString(),
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 30,
                          fontFamily: "Dongle"
                      ),
                    ),
                  ),
                ],
              )
            ),
            FutureBuilder(
              builder: (context,snapshot) {
                if(!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                else if(snapshot.hasData) {
                  return Container(
                      padding: const EdgeInsets.fromLTRB(25,40,25,0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Available Buses",
                          style: TextStyle(
                            fontSize: 21,
                              fontWeight: FontWeight.w500
                          )
                        ),
                        SizedBox(height: 30),
                        for(var bus in buses)
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pushNamed('/busDescription',arguments:bus["busNumber"]);
                            },
                            child: Container(
                              padding:EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.directions_bus
                                  ),
                                  SizedBox(width: 18),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          bus["busNumber"],
                                          style: TextStyle(
                                              fontSize: 19
                                          )
                                      ),
                                      SizedBox(width:3),
                                      Row(
                                        children: [
                                          Text(
                                              "Expected Time:  ",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              )
                                          ),
                                          Text(
                                              bus["expected_time"],
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              )
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ),
                          )
                      ],
                    )
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
            )
          ],
        ),
      )
    );
  }
}
