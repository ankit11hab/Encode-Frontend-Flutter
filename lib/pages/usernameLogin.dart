import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsernameLogin extends StatefulWidget {
  const UsernameLogin({Key? key}) : super(key: key);

  @override
  _UsernameLoginState createState() => _UsernameLoginState();
}

class _UsernameLoginState extends State<UsernameLogin> {
  late String username;
  bool showCircularIndicator = false;
  bool showUsernameValError = false;

  void handleUsernameChange(String value) {
    setState(() {
      username = value;
    });
    print(username);
  }
  Future<void> validateUsername() async {
    setState(() {
      showUsernameValError = false;
      showCircularIndicator = true;
    });
    var res = await http.post("https://27e8-146-196-45-54.ngrok.io/auth/check_username_exists/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:jsonEncode(<String, String>{
      'username': username,
    }));
    setState(() {
      showCircularIndicator=false;
    });
    print(res.body);
    if(res.body=='true')
      Navigator.of(context).pushNamed('/passwordLogin',arguments:username);
    else{
      setState(() {
        showUsernameValError=true;
      });
    }
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
                SizedBox(height: 27),
                Text(
                    "Once you login, your username will be used for all ride-related communication and ticket purchases.",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                        fontSize: 16
                    )
                ),
                SizedBox(height:60),
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
                showCircularIndicator?Padding(
                  padding: const EdgeInsets.fromLTRB(0,50,0,0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ):SizedBox(),
                showUsernameValError?Container(
                  padding: EdgeInsets.fromLTRB(10, 6, 0, 0),
                  child: Text("Username does not exist *",
                    style:TextStyle(
                      color: Colors.red,
                      fontSize: 15
                    )
                  )
                ):SizedBox(),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      onPressed: validateUsername,
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
