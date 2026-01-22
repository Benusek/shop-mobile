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
  final String? surname;
  final String? patronymic;
  final String login;
  final bool male;
  final DateTime birthday;
  final DateTime created;

  User({
    required this.id,
    required this.name,
    this.surname,
    this.patronymic,
    required this.login,
    required this.male,
    required this.birthday,
    required this.created
  });

  factory User.fromJson(Map<String, dynamic> json) {
    json = json['data']['user'];
    return User(
      id: json['id'],
      name: json['first_name'],
      surname: json['second_name'],
      patronymic: json['last_name'],
      login: json['login'],
      male: json['male'] == 1 ? true : false,
      birthday: DateTime.parse(json['birthday']),
      created: DateTime.parse(json['created_at'])
    );
  }
}

