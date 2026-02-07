class Project {
  final String title;
  final String datestart;
  final String gender;

  const Project({
    required this.title,
    required this.datestart,
    required this.gender,
  });

  factory Project.fromJson(Map <String, dynamic> json) {
    return Project(
      title: json['title'],
      datestart: json['date_start'],
      gender: json['gender']
    );
  }
}

enum ProjectType {
  casual(code: 'casual', title: 'Casual'),
  sport(code: 'sport', title: 'Sport'),
  classic(code: 'classic', title: 'Classic');

  final String code;
  final String title;

  const ProjectType({required this.code, required this.title});
}

enum ProjectCategory {
  fashion(code: 'fashion', title: 'Мода');

  final String code;
  final String title;

  const ProjectCategory({required this.code, required this.title});
}
