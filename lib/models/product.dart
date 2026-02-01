class Product {
  final String title;
  final int price;
  final String gender;
  final String description;
  final String weight;

  Product({
    required this.title,
    required this.price,
    required this.gender,
    required this.weight,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> data) {
    return Product(
      title: data['title'] as String,
      price: data['price'] as int,
      gender: data['gender'] as String,
      weight: data['weight'].toString(),
      description: data['description'] as String,
    );
  }
}
