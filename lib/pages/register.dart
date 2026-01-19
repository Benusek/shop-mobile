import 'package:flutter/material.dart';
import 'package:mobile/services/api.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SafeArea(child:
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Уже есть аккаунт? Войти',
            style: TextStyle(
              color: Colors.blueAccent
            )
          )
        )
      )
    );
  }
}
