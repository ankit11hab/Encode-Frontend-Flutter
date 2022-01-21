import 'package:encode2/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrentBookings extends StatefulWidget {
  const CurrentBookings({Key? key}) : super(key: key);

  @override
  _CurrentBookingsState createState() => _CurrentBookingsState();
}

class _CurrentBookingsState extends State<CurrentBookings> {
  @override
  List<dynamic> bookings = activeBookings['data'];
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Current Bookings",
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w500
                )
            ),
            Container(
              margin:EdgeInsets.fromLTRB(0,20,0,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for(var booking in bookings)
                    GestureDetector(
                      onTap:() {
                        Navigator.of(context).pushNamed('/pass',arguments: booking['paymentID']);
                      },
                      child:Container(
                          padding:EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Icon(
                                    Icons.list,
                                    color: Colors.blue[800],
                                    size: 30
                                ),
                                SizedBox(width:18),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        booking["paymentID"].toString().substring(0,12),
                                        style: TextStyle(
                                            fontSize: 19
                                        )
                                    ),
                                    SizedBox(height:3),
                                    Text(
                                        booking["busNumber"].toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        )
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                      ),
                    )


                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
