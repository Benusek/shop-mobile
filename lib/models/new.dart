class New {
  final String image;

  New({required this.image});

  factory New.fromJson(Map<String, dynamic> data) {
    return New(
        image: data['news_image'] as String,
    );
  }
}