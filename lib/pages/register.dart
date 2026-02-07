import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:mobile/services/api.dart';
import 'package:mobile/models/user.dart';

import '../presentations/forms/form_field_config.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formGlobalKey = GlobalKey<FormState>() ;
  DateTime? selectedDate = DateTime.now();

  final fields = [
    FormFieldConfig(code: 'firstname', placeholder: 'Имя', type: FormFieldType.text),
    FormFieldConfig(code: 'lastname', placeholder: 'Фамилия', type: FormFieldType.text),
    FormFieldConfig(code: 'secondname', placeholder: 'Отчество', type: FormFieldType.text),
    FormFieldConfig(
      code: 'datebirthday',
      placeholder: 'Дата рождения',
      type: FormFieldType.date
    ),
    FormFieldConfig(code: 'gender', placeholder: 'Пол', type: FormFieldType.select, options: Gender.values),
    FormFieldConfig(
      code: 'email',
      placeholder: 'Почта',
      type: FormFieldType.text,
    ),
  ];

  Widget buildWithLabel(String label, Widget field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Label(text: label),
        field
      ],
    );
  }

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
                        final field = fields[index];
                        switch (field.type) {
                          case FormFieldType.text:
                            return buildWithLabel(field.label!, Input(
                              labelText: field.placeholder,
                              saved: (value) => field.setValue(value!),
                            ));
                          case FormFieldType.select:
                            return buildWithLabel(field.label!, Select(
                              label: field.placeholder,
                              items: field.options!
                                  .map(
                                    (e) =>
                                    DropdownMenuItem(
                                      value: e,
                                      child: Text(e.title),
                                    ),
                              ).toList(),
                              func: (value) => field.setValue(value.code),
                            ));
                          case FormFieldType.date:
                            return buildWithLabel(field.label!, Input(
                              labelText: field.placeholder,
                              tap: () async {
                                final DateTime? dateTime = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime.now(),
                                  initialDate: selectedDate,
                                  lastDate: DateTime(3000),
                                );
                                if (dateTime != null) {
                                  setState(() {
                                    selectedDate = dateTime;
                                  });
                                }
                              },
                            ));
                        }
                      },
                    ),
                  ),
                ),
              CompletedButton(
                text: 'Далее',
                func: () {
                  if (_formGlobalKey.currentState!.validate()) {
                    _formGlobalKey.currentState!.save();
                    Map<String, dynamic> data = {};
                    for (var field in fields) {
                      data[field.code] = field.value;
                    }

                    //TODO: Api response with error of this values => other page opened
                    Navigator.pushNamed(context, '/password', arguments: data);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
