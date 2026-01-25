import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:mobile/services/api.dart';
import 'package:mobile/models/user.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late Gender _selectedGender = Gender.men;

  Widget input(String title, TextInputType? type) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Input(labelText: title, keyboardType: type ?? TextInputType.text),
    );
  }

  Widget select() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Select(
        label: 'Пол',
        func: (value) => _selectedGender = value!,
        items: Gender.values.map((gender) {
          return DropdownMenuItem(value: gender, child: Text(gender.title));
        }).toList(),
      ),
    );
  }

  late final List<Map<String, dynamic>> inputs = [
    {'code': 'firstname', 'widget': input('Имя', null)},
    {'code': 'lastname', 'widget': input('Фамилия', null)},
    {'code': 'secondname', 'widget': input('Отчество', null)},
    {
      'code': 'datebirthday',
      'widget': input('Дата рождения', TextInputType.datetime),
    },
    {'code': 'gender', 'widget': select()},
    {'code': 'email', 'widget': input('Почта', TextInputType.emailAddress)},
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
              Description(
                text:
                    'В профиле будут храниться результаты проектов и ваши описания.',
              ),
              SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  itemCount: inputs.length,
                  itemBuilder: (context, index) {
                    return inputs[index]['widget'];
                  },
                ),
              ),
              CompletedButton(
                text: 'Далее',
                func: () {
                  setState(() {
                    Navigator.pushNamed(context, '/password', arguments: {});
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
