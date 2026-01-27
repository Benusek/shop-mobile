import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:mobile/services/api.dart';
import 'package:mobile/models/user.dart';

import '../presentaions/forms/form_field_config.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formGlobalKey = GlobalKey<FormState>() ;
  late Gender _selectedGender;
  final fields = [
    FormFieldConfig(code: 'firstname', label: 'Имя'),
    FormFieldConfig(code: 'lastname', label: 'Фамилия'),
    FormFieldConfig(code: 'secondname', label: 'Отчество'),
    FormFieldConfig(
      code: 'datebirthday',
      label: 'Дата рождения',
      type: TextInputType.datetime,
    ),
    FormFieldConfig(code: 'gender', label: 'Пол', isSelect: true),
    FormFieldConfig(
      code: 'email',
      label: 'Почта',
      type: TextInputType.emailAddress,
    ),
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
                  child: Form(
                    key: _formGlobalKey,
                    child: ListView.builder(
                      itemCount: fields.length,
                      itemBuilder: (context, index) {
                        return fields[index].isSelect
                            ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Select(
                            label: 'Пол',
                            func: (value) => _selectedGender = value!,
                            items: Gender.values.map((gender) {
                              return DropdownMenuItem(
                                value: gender,
                                child: Text(gender.title),
                              );
                            }).toList(),
                          ),
                        )
                            : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Input(
                            labelText: fields[index].label,
                            keyboardType:
                            fields[index].type ?? TextInputType.text,
                            saved: (value) {
                              print(value);
                              fields[index].setValue(value!);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              CompletedButton(
                text: 'Далее',
                func: () {
                  _formGlobalKey.currentState!.save();
                  Map<String, dynamic> data = Map();
                  for (int i = 0; i < fields.length; i++) {
                    switch (fields[i].code) {
                      case 'email':
                        break;
                      case 'gender':
                        data[fields[i].code] = _selectedGender.code ? 'male': 'female';
                        break;
                      default:
                        data[fields[i].code] = fields[i].value;
                        break;
                    }
                  }
                  print(data);
                  Api().register(data, fields[5].value.toString(), '123123');
                  // Navigator.pushNamed(context, '/password', arguments: {data, data[fields[5].value], '123' });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
