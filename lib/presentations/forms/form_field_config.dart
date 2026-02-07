enum FormFieldType {
  text,
  date,
  select
}

class FormFieldConfig {
  final String code;
  final String? label;
  final String placeholder;
  final FormFieldType type;
  final List? options;
  late String? value;

  FormFieldConfig({
    required this.code,
    this.label,
    required this.placeholder,
    required this.type,
    this.options
  });

  void setValue (String value) {
    this.value = value;
  }
}
