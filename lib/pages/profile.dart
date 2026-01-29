import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/services/api.dart';
import 'package:ui/ui.dart';
import 'package:mobile/services/secure_storage.dart';
import 'package:mobile/models/user.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final SecureStorage _storage = SecureStorage();
  late String? token;
  late Map<String, dynamic> user;

  Future<void> getData() async {
    token = await _storage.readSecureData('token');
    var data = await _storage.readSecureData('user.data');
    user = jsonDecode(data!);
  }

  @override
  void initState () {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 32, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Heading(text: user['firstname']),
                SizedBox(height: 8),
                Text(user['email'], style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF939396)
                )),
                SizedBox(height: 24),
                Column(
                  children: [
                    SizedBox(
                      height: 64,
                      child: Row(
                        children: [
                          Image.asset('assets/notebook_icon.png'),
                          SizedBox(width: 20),
                          Text('Мои заказы', style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17
                          ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 64,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/settings_icon.png'),
                              SizedBox(width: 20),
                              Text('Уведомления', style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17
                              ))
                            ],
                          ),
                          Text('Switch')
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 176),
                Center(
                  child: Column(
                    children: [
                      TextMedium(text: 'Политика конфиденциальности'),
                      SizedBox(height: 24),
                      TextMedium(text: 'Пользовательское соглашение'),
                      SizedBox(height: 24),
                      TextButton(
                        onPressed: () {
                          Api().logout();
                          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                        },
                        child: TextMedium(text: 'Выход', color: Color(0xFFFD3535)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
