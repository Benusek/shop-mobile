class Product {
  final String title;
  final int price;
  final String gender;
  Product({required this.title, required this.price, required this.gender});

  factory Product.fromJson(Map<String, dynamic> data) {
    return Product(
      title: data['title'] as String,
      price: data['price'] as int,
      gender: data['gender'] as String
    );
  }
}