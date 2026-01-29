import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/services/secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Api {
  final supabase = Supabase.instance.client;
  final secureStorage = SecureStorage();
  Future<dynamic>? auth(String email, String pass) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: pass,
      );

      final Session? session = res.session;
      final user = await supabase.from('users').select().limit(1).single();

      await secureStorage.writeSecureData('token', session!.accessToken);
      await secureStorage.writeSecureData('user.data', jsonEncode(user));

    } on AuthException catch (error) {
      print(error.message);
    }
  }

  void logout() async {
    await supabase.auth.signOut();
    secureStorage.deleteAllData();
  }

  void register(Map <String, dynamic> data, String email, String password) async {
    print(data);
    print(email);
    print(password);
    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      final Session? session = res.session;
      final user = res.user;
      if (user == null) return;
      data['id'] = user.id;
      await supabase.from('users').insert(data);
      print(session);
      // final User? user = res.user;
    } on Exception catch (error) {
      print(error);
    }
  }
}
