import 'dart:convert';

import 'package:encode2/constants.dart';
import 'package:encode2/pages/components/currentbookings.dart';
import 'package:encode2/pages/components/currentlocation.dart';
import 'package:encode2/pages/components/purchaseHistory.dart';
import 'package:encode2/pages/components/searchresults.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  String currSearch = "";
  List<dynamic> searchRes = [];
  Future<void> getSearchResults(val) async {
    setState(() {
      currSearch=val;
    });
    if(val.length==0){
      setState(() {
        searchRes=[];
      });
    }
    if(val!="") {
      var res = await http.post("https://a4d0-146-196-45-54.ngrok.io/geo/autocomplete/",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $access',
          },
          body:jsonEncode(<String, String>{
            'lat': currLat,
            'lng': currLng,
            'query': val
          }));
      Map<dynamic,dynamic> m = json.decode(res.body);
      setState(() {
        searchRes = m['predictions'];
      });
    }
  }
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.fromLTRB(25,90,25,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome $first_name,",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 46,
                      fontFamily: "Dongle"
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0,-25),
                    child: Text(
                      currLocation1,
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 30,
                          fontFamily: "Dongle"
                      ),
                    ),
                  ),
                  Spacer(),
                  TextField(
                    onChanged: getSearchResults,
                    style: TextStyle(
                        fontSize: 16,
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15,0,15,0),
                      prefixIcon: Icon(Icons.search,color: Colors.grey[300]),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Colors.lightBlue, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Colors.lightBlue, width: 1),
                      ),
                      hintText: "Search here",
                      hintStyle: TextStyle(color: Colors.grey[300]),
                    ),
                  ),
                  SizedBox(height:25)
                ],
              ),
            ),
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
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15,20,15,0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(8, 30, 8, 10),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          currSearch!=""?
                              Container(
                                child: searchRes.length!=0?
                                    Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          for(var item in searchRes)
                                            GestureDetector(
                                              onTap: (){
                                                Navigator.of(context).pushNamed('/findBuses',arguments:item["place_id"]);
                                              },
                                              child: Container(
                                                padding:EdgeInsets.fromLTRB(0, 5, 0, 5),
                                                child: SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on
                                                      ),
                                                      SizedBox(width:18),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            item['structured_formatting']['main_text'],
                                                            style: TextStyle(
                                                              fontSize: 19
                                                            )
                                                          ),
                                                          SizedBox(width:3),
                                                          Text(
                                                              item['structured_formatting']['secondary_text'],
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.grey,
                                                              )
                                                          ),
                                                        ],
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          SizedBox(height:30)
                                        ],
                                      )
                                    )
                                    :
                                    Center(
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator()
                                      ),
                                    )
                              )
                              :
                          SizedBox(),
                          (currentBooks.length!=0)?CurrentBookings():SizedBox(),
                          SizedBox(height:30),
                          Text(
                              "Travel History",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w500
                            )
                          ),
                          PurchaseHistory()
                        ],
                      ),
                    ],
                  )
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
