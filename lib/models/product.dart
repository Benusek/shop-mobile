class Product {
  final String id;
  final String title;
  final int price;
  final String gender;
  final String description;
  final String weight;
  bool added;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.gender,
    required this.weight,
    required this.description,
    this.added = false
  });

  factory Product.fromJson(Map<String, dynamic> data) {
    return Product(
      id: data['id'],
      title: data['title'],
      price: data['price'],
      gender: data['gender'],
      weight: data['weight'].toString(),
      description: data['description'],
    );
  }
}
