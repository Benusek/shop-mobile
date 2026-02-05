import 'package:flutter/material.dart';
import 'package:mobile/presentations/forms/form_field_config.dart';
import 'package:ui/ui.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({super.key});

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  final fields = [
    FormFieldConfig(code: 'firstname', placeholder: 'Выбирите тип', label: 'Тип'),
    FormFieldConfig(code: 'lastname', placeholder: 'Введите имя', label: 'Название проекта'),
    FormFieldConfig(code: 'datestart', placeholder: '--.--.----', label: 'Дата начала'),
    FormFieldConfig(code: 'dateover', placeholder: '--.--.----', label: 'Дата окончания'),
    FormFieldConfig(
      code: 'datebirthday',
      placeholder: 'Выберите кому',
      isSelect: true, label: 'Кому',
    ),
    FormFieldConfig(code: 'gender', placeholder: 'example.com', isSelect: true, label: 'Источник описания'),
    FormFieldConfig(code: 'category', placeholder: 'Выберети категорию', isSelect: true, label: 'Категория'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Heading(text: 'Создать проект'),
              Expanded(
                child: ListView.builder(
                  itemCount: fields.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ?fields[index].label != null ? Label(text: fields[index].label!): null,
                          Input(
                            labelText: fields[index].placeholder,
                            keyboardType: fields[index].type ?? TextInputType.text,
                            saved: (value) {
                              print(value);
                              fields[index].setValue(value!);
                            },
                            validator: (value) {
                              if (value!.isEmpty &&
                                  ![
                                    'secondname',
                                    'lastname',
                                  ].contains(fields[index].code)) {
                                return 'This field is required';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: 200,
                height: 200,
                color: Colors.grey.shade200,
                child: Icon(Icons.add, color: Colors.grey, size: 125),
              )
            ],
          ),
        ),
      ),
    );
  }
}
