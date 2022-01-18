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
        return MaterialPageRoute(builder: (_)=>Home());
      case '/loginOptions':
        return MaterialPageRoute(builder: (_)=>LoginOptions());
      case '/login':
        return MaterialPageRoute(builder: (_)=>Login());
      case '/usernameLogin':
        return MaterialPageRoute(builder: (_)=>UsernameLogin());
      case '/passwordLogin':
        return MaterialPageRoute(builder: (_)=>PasswordLogin(username:args));
      default:
        return MaterialPageRoute(builder: (_)=>LoginOptions());
    }
  }
}