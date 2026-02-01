class New {
  final String? image;
  final String title;
  final String? price;

  New({this.image, required this.title, this.price});

  factory New.fromJson(Map<String, dynamic> data) {
    return New(
      image: data['news_image']?.toString(),
      title: data['title'],
      price: data['price']?.toString(),
    );
  }
}
