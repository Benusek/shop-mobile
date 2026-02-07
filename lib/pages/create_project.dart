import 'package:flutter/material.dart';
import 'package:mobile/models/project.dart';
import 'package:mobile/models/user.dart';
import 'package:mobile/presentations/forms/form_field_config.dart';
import 'package:ui/ui.dart';

class CreateProject extends StatefulWidget {
  const CreateProject({super.key});

  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  DateTime? selectedDate = DateTime.now();

  final fields = [
    FormFieldConfig(
      code: 'type',
      placeholder: 'Выбирите тип',
      label: 'Тип',
      type: FormFieldType.select,
      options: ProjectType.values,
    ),
    FormFieldConfig(
      code: 'title',
      placeholder: 'Введите имя',
      label: 'Название проекта',
      type: FormFieldType.text,
    ),
    FormFieldConfig(
      code: 'date_start',
      placeholder: '--.--.----',
      label: 'Дата начала',
      type: FormFieldType.date,
    ),
    FormFieldConfig(
      code: 'date_end',
      placeholder: '--.--.----',
      label: 'Дата окончания',
      type: FormFieldType.date,
    ),
    FormFieldConfig(
      code: 'gender',
      placeholder: 'Выберите кому',
      label: 'Кому',
      type: FormFieldType.select,
      options: Gender.values,
    ),
    FormFieldConfig(
      code: 'description_source',
      placeholder: 'example.com',
      label: 'Источник описания',
      type: FormFieldType.text,
    ),
    FormFieldConfig(
      code: 'category',
      placeholder: 'Выберети категорию',
      label: 'Категория',
      type: FormFieldType.select,
      options: ProjectCategory.values,
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
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 15),
          child: Column(
            children: [
              Heading(text: 'Создать проект'),
              SizedBox(height: 31),
              Expanded(
                child: ListView.separated(
                  itemCount: fields.length + 1,
                  itemBuilder: (context, index) {
                    if (index == fields.length) {
                      return Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 200,
                          height: 200,
                          color: Colors.grey.shade200,
                          child: Icon(Icons.add, color: Colors.grey, size: 125),
                        ),
                      );
                    }

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
                                (e) => DropdownMenuItem(
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
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 24);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
