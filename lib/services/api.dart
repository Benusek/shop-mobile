import 'package:http/http.dart';

class Api {
  String domain = 'http://127.0.0.1:8000/api';
  Future<void> auth() async {
    try {
      Response response = await get(Uri.parse('$domain/collections/users/auth-with-password'));
      print(response);
    } catch (err) {
      print(err);
    }
  }
  void logout () async {

  }

  void register () async {

  }
}