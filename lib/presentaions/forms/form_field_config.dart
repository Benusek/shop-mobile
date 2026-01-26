import 'package:flutter/cupertino.dart';

class FormFieldConfig {
  final String code;
  final String label;
  final TextInputType? type;
  final bool isSelect;
  String? value;

  FormFieldConfig({
    required this.code,
    required this.label,
    this.type = TextInputType.text,
    this.isSelect = false,
  });

  void setValue (String value) {
    this.value = value;
  }
}
