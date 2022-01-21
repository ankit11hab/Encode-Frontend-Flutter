import 'package:encode2/constants.dart';
import 'package:encode2/pages/busdescription.dart';
import 'package:encode2/pages/findbuses.dart';
import 'package:encode2/pages/home.dart';
import 'package:encode2/pages/login.dart';
import 'package:encode2/pages/loginOptions.dart';
import 'package:encode2/pages/passwordLogin.dart';
import 'package:encode2/pages/usernameLogin.dart';
import 'package:flutter/material.dart';
import 'package:encode2/main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch(settings.name) {
      case '/':
        if(access=="")
          return MaterialPageRoute(builder: (_)=>LoginOptions());
        return MaterialPageRoute(builder: (_)=>Home());
      case '/findBuses':
        if(access=="")
          return MaterialPageRoute(builder: (_)=>LoginOptions());
        return MaterialPageRoute(builder: (_)=>FindBuses(place_id:args));
      case '/busDescription':
        if(access=="")
          return MaterialPageRoute(builder: (_)=>LoginOptions());
        return MaterialPageRoute(builder: (_)=>BusDescription(busNumber:args));
      case '/loginOptions':
        if(access!="")
          return MaterialPageRoute(builder: (_)=>Home());
        return MaterialPageRoute(builder: (_)=>LoginOptions());
      case '/login':
        if(access!="")
          return MaterialPageRoute(builder: (_)=>Home());
        return MaterialPageRoute(builder: (_)=>Login());
      case '/usernameLogin':
        if(access!="")
          return MaterialPageRoute(builder: (_)=>Home());
        return MaterialPageRoute(builder: (_)=>UsernameLogin());
      case '/passwordLogin':
        if(access!="")
          return MaterialPageRoute(builder: (_)=>Home());
        return MaterialPageRoute(builder: (_)=>PasswordLogin(username:args));
      default:
        return MaterialPageRoute(builder: (_)=>LoginOptions());
    }
  }
}