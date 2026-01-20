import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:mobile/services/api.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  List<String> inputs = [
    'Имя', 'Отчество', 'Фамилия', 'Дата рождения', 'Пол', 'Почта'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 32, 20, 32),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Heading(text: 'Создание профиля'),
              SizedBox(height: 44),
              Description(text: 'Без профиля вы не сможете создавать проекты.'),
              SizedBox(height: 8),
              Description(text: 'В профиле будут храниться результаты проектов и ваши описания.'),
              SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  itemCount: inputs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical:12),
                      child: Input(
                          func: (value) {
                          },
                          labelText: inputs[index]
                      ),
                    );
                  },
                ),
              ),
              CompletedButton(
                text: 'Далее',
                func: () {
                  setState(() {
                    print('completed');
                    Navigator.pushReplacementNamed(context, '/password');
                  });
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
