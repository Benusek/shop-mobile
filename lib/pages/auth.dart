import 'package:flutter/material.dart';
import 'package:mobile/services/api.dart';
import 'package:ui/ui.dart';
import 'package:mobile/models/user.dart';

import '../models/session.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool hasError = false;
  String emailError = '';
  String passError = '';
  bool hide = true;
  final _formGlobalKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

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
                    saved: (value) {
                      _email = value!;
                    },
                    error: hasError && emailError.isNotEmpty
                        ? emailError
                        : null,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'The email field is required';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'example@gmail.com',
                  ),
                  SizedBox(height: 14),
                  Label(text: 'Пароль'),
                  Input(
                    saved: (value) {
                      _password = value!;
                    },
                    error: hasError && passError.isNotEmpty ? passError : null,
                    // validator: (value) {
                    //   if (value!.length < 8) {
                    //     return 'The password must contain at least 8 characters.';
                    //   }
                    //   return null;
                    // },
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
                  ),
                  SizedBox(height: 14),
                  CompletedButton(
                    text: 'Далее',
                    func: () async {
                      setState(() {
                        if (_formGlobalKey.currentState!.validate()) {
                          _formGlobalKey.currentState!.save();
                        }
                      });
                      await Api().auth(_email, _password);
                      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
                    },
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
