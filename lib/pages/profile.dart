import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Имя'),
            Text('Почта'),
            Text('Мои заказы'),
            Text('Уведомления'),
            Text('Политика конфиденциальности'),
            Text('Пользовательское соглашение'),
            Text('Выход'),
          ],
        ),
      ),
    );
  }
}
