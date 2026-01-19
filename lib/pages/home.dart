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
                  Text(
                    '✋',
                    style: TextStyle(
                      fontSize: 32,
                    )
                  ),
                  SizedBox(width:16),
                  Text(
                    'Добро пожаловать!',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.0033
                    ),
                  )
                ],
              ),
              SizedBox(height: 23),
              Text(
                  'Войдите чтобы пользовать функциями приложения',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                  )
              ),
              SizedBox(height: 64),
              Text(
                'Вход по E-mail',
                style: TextStyle(
                  color: Colors.black54
                )
              ),
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
              Text(
                  'Пароль',
                  style: TextStyle(
                      color: Colors.black54
                  )
              ),
              TextField(
                obscureText: hide,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2
                    ),
                  ),
                  fillColor:  Color(0xFFF5F5F9),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  suffixIcon: IconButton(
                    icon: Icon(hide?Icons.visibility: Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        hide = !hide;
                      });
                    },
                    highlightColor: Colors.transparent,
                  )
                ),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                }
              ),
              SizedBox(height:14),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      Api get = Api();
                      get.auth();
                    });
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    'Далее',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600
                    )
                  )
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    'Зарегистрироваться',
                    style: TextStyle(
                      color: Colors.blue
                    )
                  )
                ),
              )
            ],
          ),
        )
    );
  }
}
