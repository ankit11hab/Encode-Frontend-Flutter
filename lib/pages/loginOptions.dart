import 'package:flutter/material.dart';

class LoginOptions extends StatefulWidget {
  const LoginOptions({Key? key}) : super(key: key);

  @override
  _LoginOptionsState createState() => _LoginOptionsState();
}

class _LoginOptionsState extends State<LoginOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 70, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image(
                image: AssetImage('assets/car.jpg'),
                width: 380,
              ),
            ),
            SizedBox(height:40),
            Padding(
              padding: const EdgeInsets.fromLTRB(10,0,0,0),
              child: Text(
                "Explore new ways to\ntravel with us",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3
                )
              ),
            ),
            SizedBox(height:35),
            FlatButton(
              onPressed: (){
                Navigator.of(context).pushNamed('/usernameLogin');
              },
              child: Text("Continue with Username",
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
            SizedBox(height:30),
            Center(
              child: Text(
                  "Don't have an account?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 15,
                ),
              )
            ),
            Transform.translate(
              offset: const Offset(0.0, -12),
              child: Center(
                child: FlatButton(
                  onPressed: (){},
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color:Colors.blue,
                    ),
                  ),
                  height: 0,
                ),

              ),
            ),
            SizedBox(height:18),
            Text(
              "This app has been developed by Ankit Guha,Suvayan Nath, Vighnesh Deshpande and Ayush Datta Jaiswal: TEAM SE.",
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w400
              )
            )
          ],
        ),
      )
    );
  }
}
