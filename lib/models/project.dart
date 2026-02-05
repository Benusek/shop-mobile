class Project {

}

enum Type {
  casual(code: 'casual', title: 'Casual'),
  sport(code: 'sport', title: 'Sport'),
  classic(code: 'classic', title: 'Classic');


  final String code;
  final String title;
  const Type({required this.code, required this.title});
}

enum Category {
  fashion(code: 'fashion', title: 'Мода');

  final String code;
  final String title;
  const Category({required this.code, required this.title});
}

