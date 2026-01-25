import 'dart:convert';

import 'package:mobile/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Api {
  Future<dynamic>? auth(String email, String pass) async {
    final supabase = Supabase.instance.client;

    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: pass,
      );
    } on AuthException catch (error) {
      print(error.message);
    }
  }

  void logout() async {}

  void register() async {}
}
