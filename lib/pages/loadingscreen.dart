import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Icon(
                Icons.location_on,
                size: 40,
                color: Colors.blue[800],
              )
            ),
            SizedBox(height:20),
            Text(
              "Kindly wait as we load\nyour info",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20
              )
            ),
            SizedBox(height:20),
            Container(width: 80,child: LinearProgressIndicator())
          ],
        ),
      )
    );
  }
}
