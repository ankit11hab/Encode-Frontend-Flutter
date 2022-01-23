import 'dart:convert';

import 'package:encode2/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BusDescription extends StatefulWidget {
  final Object? busNumber;
  const BusDescription({Key? key, required this.busNumber}) : super(key: key);

  @override
  _BusDescriptionState createState() => _BusDescriptionState();
}

class _BusDescriptionState extends State<BusDescription> {

  late Razorpay razorpay;
  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }
  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key" : "rzp_test_11LV9V2xBmW3uJ",
      "amount" : 1000,
      "name" : "BusEncode",
      "description" : "Bus booking",
      "prefill" : {
        "contact" : "9378063452",
         "email" : "ankit11hab@gmail.com",
      },
      "external" : {
        "wallets" : ["paytm"],
      }
    };
    try{
      razorpay.open(options);
      bookTicket();
    }catch(e) {
      print(e.toString());
    }
  }

  void handlePaymentSuccess() {
    print("Payment Success");
  }

  void handlePaymentFailure() {
    print("Payment Failure");
  }

  void handleExternalWallet() {
    print("External Wallet");
  }

  late final Future myFuture= getBusDescription();
  List<dynamic> routes=[];
  Future<void> bookTicket() async{
    var res = await http.post(urlF+"driver/book/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access',
        },
        body:jsonEncode(<String, String>{
          'busNumber': widget.busNumber.toString(),
        }));
    if(res.statusCode==200)
      Navigator.of(context).pushNamed('/');
  }
  Future<int> getBusDescription() async {
    var res = await http.post(urlF+"driver/get/bus/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $access',
        },
        body:jsonEncode(<String, String>{
          'busNumber': widget.busNumber.toString(),
        }));
    print(res.body);
    Map<String,dynamic> m = jsonDecode(res.body);
    setState(() {
      routes=m['data'];
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
                    "Bus Description",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 46,
                        fontFamily: "Dongle"
                    )
                  ),
                  Transform.translate(
                    offset: Offset(0,-25),
                    child: Text(
                      widget.busNumber.toString(),
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
                  return Center(child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: CircularProgressIndicator(),
                  ));
                }
                else if(snapshot.hasData) {
                  return Container(
                      padding: const EdgeInsets.fromLTRB(25,40,25,0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Bus Route",
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w500
                              )
                          ),
                          SizedBox(height: 30),
                          for(var route in routes)
                            GestureDetector(
                              child: Container(
                                  padding:EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Row(
                                    children: [
                                      Icon(
                                          Icons.radio_button_checked
                                      ),
                                      SizedBox(width: 18),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              route["location"],
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
                                                  route["expected_time"],
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
                            ),
                          SizedBox(height:175),
                          FlatButton(
                            onPressed: openCheckout,
                            child: Text("Book a Ticket",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:19,
                                )
                            ),
                            color:Colors.grey[850],
                            minWidth: 400,
                            height: 46,
                            shape: RoundedRectangleBorder(side: BorderSide(
                                width: 1,
                                style: BorderStyle.solid
                            ),
                                borderRadius: BorderRadius.circular(9)),
                          ),
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
          ]
        )
      )
    );
  }
}
