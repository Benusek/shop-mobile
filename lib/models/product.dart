class Product {
  final String title;
  final String price;
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
      title: data['title'],
      price: data['price'].toString(),
      gender: data['gender'],
      weight: data['weight'].toString(),
      description: data['description'],
    );
  }
}
