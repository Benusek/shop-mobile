class Project {

}

enum Type {

}

enum Category {
  fashion(code: 'fashion', title: 'Мода');

  final String code;
  final String title;
  const Category({required this.code, required this.title});
}

