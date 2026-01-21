enum Gender {
  men(title: 'Мужской', code: true),
  woman(title: 'Женский', code: false);

  final String title;
  final bool code;

  const Gender({required this.title, required this.code});
}

class User {
  final int id;
  final String name;
  final String surname;
  final String patronymic;
  final String login;
  final bool male;
  final DateTime birthday;
  final DateTime created;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.patronymic,
    required this.login,
    required this.male,
    required this.birthday,
    required this.created
  });

}

