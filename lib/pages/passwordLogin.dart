import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:encode2/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordLogin extends StatefulWidget {
  final Object? username;
  const PasswordLogin({Key? key, required this.username}) : super(key: key);

  @override
  _PasswordLoginState createState() => _PasswordLoginState();
}

class _PasswordLoginState extends State<PasswordLogin> {

  late String password;
  bool showCircularIndicator = false;
  bool showLoginError = false;

  void handleUsernameChange(String value) {
    setState(() {
      password = value;
    });
  }

  late SharedPreferences prefs;
  late String accessPref;
  late String refreshPref;

  Future<void> loginUser() async {
    setState(() {
      showCircularIndicator=true;
      showLoginError=false;
    });
    var res = await http.post("https://1d64-146-196-45-54.ngrok.io/auth/token/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:jsonEncode(<String, String>{
          'username': widget.username.toString(),
          'password':password
        }));
    setState(() {
      showCircularIndicator=false;
    });
    if(res.statusCode!=200){
      setState(() {
        showLoginError=true;
      });
    }
    else{
      Map<String,dynamic> tokens = jsonDecode(res.body);
      print(tokens['access']);
      access = tokens['access'];
      refresh = tokens['refresh'];
      prefs = await SharedPreferences.getInstance();
      prefs.setString('accessPref',access);
      prefs.setString('refreshPref',refresh);
      Navigator.of(context).pushNamed('/');
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
                    hintText: 'Password',
                  ),
                  obscureText: true,
                ),
                showCircularIndicator?Padding(
                  padding: const EdgeInsets.fromLTRB(0,50,0,0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ):SizedBox(),
                showLoginError?Container(
                    padding: EdgeInsets.fromLTRB(10, 6, 0, 0),
                    child: Text("Invalid Password *",
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
                      onPressed: loginUser,
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
