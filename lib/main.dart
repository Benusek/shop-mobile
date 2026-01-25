import 'package:flutter/material.dart';
import 'package:mobile/pages/create_password.dart';
import 'package:mobile/pages/auth.dart';
import 'package:mobile/pages/navigation.dart';
import 'package:mobile/pages/register.dart';
import 'package:mobile/pages/splash.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/splash',
    routes: {
      '/': (context) => Auth(),
      '/register': (context) => Register(),
      '/password': (context) => CreatePassword(),
      '/splash': (context) => Splash(),
      '/home': (context) => Navigation()
    },
  ));
}
