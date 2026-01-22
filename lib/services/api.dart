import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobile/models/user.dart';

class Api {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000/api',
      connectTimeout: Duration(seconds: 5), // Connection timeout
      receiveTimeout: Duration(seconds: 3), // Receive timeout
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      responseType: ResponseType.json, // Default response type
    ),
  );
  Future<dynamic> auth(String email, String pass) async {
      Map<String, String> data = {
        'email': email,
        'password': pass
      };

      try {
        Response response = await dio.post(
            '/collections/users/auth-with-password',
            data: jsonEncode(data)
        );
        final userJson = response.data;
        print(userJson);

        if (response.statusCode == 200) {
          return User.fromJson(userJson);
        }
        else {
          return userJson;
        }
      } on DioException catch (e) {
        // The request was made and the server responded with a status code
        // that falls out of the range of 2xx and is also not 304.
        if (e.response != null) {
          print(e.response!.data);
          return e.response!.data;
        } else {
          // Something happened in setting up or sending the request that triggered an Error
          print(e.requestOptions);
          print(e.message);
          throw Exception(e);
        }
      }
  }

  void logout () async {

  }

  void register () async {

  }
}