import 'package:encode2/route_generator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        brightness: Brightness.light,
      ),
    ),
    debugShowCheckedModeBanner: false,
    initialRoute: '/loginOptions',
    onGenerateRoute: RouteGenerator.generateRoute,
    )
  );
}