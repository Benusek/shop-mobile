import 'package:flutter/cupertino.dart';

class FormFieldConfig {
  final String code;
  final String? label;
  final String placeholder;
  final TextInputType? type;
  final bool isSelect;
  String? value;

  FormFieldConfig({
    required this.code,
    this.label,
    required this.placeholder,
    this.type = TextInputType.text,
    this.isSelect = false,
  });

  void setValue (String value) {
    this.value = value;
  }
}
