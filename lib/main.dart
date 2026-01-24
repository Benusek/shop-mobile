import 'package:flutter/material.dart';
import 'package:mobile/pages/create_password.dart';
import 'package:mobile/pages/home.dart';
import 'package:mobile/pages/register.dart';
import 'package:mobile/pages/splash.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/splash',
    routes: {
      '/': (context) => Home(),
      '/register': (context) => Register(),
      '/password': (context) => CreatePassword(),
      '/splash': (context) => Splash()
    },
  ));
}
