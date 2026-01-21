import 'package:flutter/material.dart';
import 'package:mobile/services/api.dart';
import 'package:ui/ui.dart';
import 'package:mobile/models/user.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool hide = true;

  final _formGlobalKey = GlobalKey<FormState>();
  String _email = '';
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
            Form(
              key: _formGlobalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Label(text: 'Вход по E-mail'),
                  Input(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'error';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'example@gmail.com',
                  ),
                  SizedBox(height: 14),
                  Label(text: 'Пароль'),
                  Input(
                      validator: (value) {
                        if (value!.length < 5) {
                          return 'error';
                        }
                        return null;
                      },
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
                      )
                  ),
                  SizedBox(height: 14),
                  CompletedButton(
                    text: 'Далее',
                    func: () => setState(() {
                      _formGlobalKey.currentState!.validate();
                      Api get = Api();
                      get.auth();
                    }),
                  ),
                ],
              ),
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
