import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PassQR extends StatefulWidget {
  final Object? paymentID;
  const PassQR({Key? key, required this.paymentID}) : super(key: key);

  @override
  _PassQRState createState() => _PassQRState();
}

class _PassQRState extends State<PassQR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
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
                padding: const EdgeInsets.fromLTRB(25,90,15,0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bus Pass",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 46,
                          fontFamily: "Dongle"
                      ),
                    ),
                  ],
                )
              )
            ),
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 140, 0, 30),
                child: QrImage(
                  data: widget.paymentID.toString(),
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            )
          ],
        )
      )
    );
  }
}
