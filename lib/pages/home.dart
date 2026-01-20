import 'package:flutter/material.dart';
import 'package:mobile/services/api.dart';
import 'package:ui/ui.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _email = '';
  String _password = '';
  bool hide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 103, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('✋', style: TextStyle(fontSize: 32)),
                SizedBox(width: 16),
                Heading(text: 'Добро пожаловать!'),
              ],
            ),
            SizedBox(height: 23),
            Text(
              'Войдите чтобы пользовать функциями приложения',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 64),
            Label(text: 'Вход по E-mail'),
            Input(
              keyboardType: TextInputType.emailAddress,
              labelText: 'example@gmail.com',
              func: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            SizedBox(height: 14),
            Label(text: 'Пароль'),
            Input(
              password: true,
              private: hide,
              suffix: IconButton(
                icon: Icon(
                  hide
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () => setState(() => hide = !hide),
                highlightColor: Colors.transparent,
              ),
              func: (value) {
                setState(() {
                  _password = value;
                  print(_password);
                });
              },
            ),
            SizedBox(height: 14),
            CompletedButton(
              text: 'Далее',
              func: _email.isNotEmpty || _password.isNotEmpty
                  ? () => setState(() {
                      Api get = Api();
                      get.auth();
                    })
                  : null,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: Text(
                  'Зарегистрироваться',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
