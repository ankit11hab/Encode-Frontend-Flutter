import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override

  late String username;

  void handleUsernameChange(String value) {
    setState(() {
      username = value;
    });
    print(username);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
            "",
            style: TextStyle(
              color: Colors.black
            )
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(25, 25, 25, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Login to your account",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3
              )
            ),
            SizedBox(height: 30),
            Text(
              "Once you login, your username will be used for all ride-related communication and ticket purchases.",
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
                fontSize: 16
              )
            ),
            SizedBox(height:65),
            TextField(
              onChanged: (value) => handleUsernameChange(value),
              style: TextStyle(
                fontSize: 19
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                hintText: 'Username',
              ),
            ),
            SizedBox(height:30),

            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: (){},
                  child: Text("Next",
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
          ],
        )
      )
    );
  }
}
