enum Gender {
  men(title: 'Мужской', code: 'male'),
  woman(title: 'Женский', code: 'female');

  final String title;
  final String code;

  const Gender({required this.title, required this.code});
}

class User {
  final String id;
  final String name;
  final String? surname;
  final String? patronymic;
  final String gender;
  final DateTime birthday;
  final DateTime created;
  final String email;

  User({
    required this.id,
    required this.name,
    this.surname,
    this.patronymic,
    required this.gender,
    required this.birthday,
    required this.created,
    required this.email
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['firstname'],
      surname: json['secondname'],
      patronymic: json['lastname'],
      email: json['email'],
      gender: json['gender'],
      birthday: DateTime.parse(json['datebirthday']),
      created: DateTime.parse(json['created'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "surname": surname,
      "patronymic": patronymic,
      "email": email,
      "gender": gender,
      "birthday": birthday,
      "created": created
    };
  }
}

