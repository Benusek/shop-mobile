import 'package:flutter/material.dart';
// import 'package:mobile/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Api {
  final supabase = Supabase.instance.client;
  Future<dynamic>? auth(String email, String pass) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: pass,
      );

      final Session? session = res.session;
      final User? user = res.user;
      print('user: $user');
      print('session: ${session!.accessToken}');
      final public = await supabase.from('users').select();
      print('user.data: $public');
    } on AuthException catch (error) {
      print(error.message);
    }
  }

  void logout(BuildContext context) async {
    await supabase.auth.signOut();
    // TODO: Navigate to screen authorization
    // Navigator.pushAndRemoveUntil(context, 'auth' as Route<Object?>, (route) => false);
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
