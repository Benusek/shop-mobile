import 'dart:convert';

import 'package:mobile/models/user.dart';

class Api {
  Future<dynamic> auth(String email, String pass) async {
      Map<String, String> data = {
        'email': email,
        'password': pass
      };
  }

  void logout () async {

  }

  void register () async {

  }
}