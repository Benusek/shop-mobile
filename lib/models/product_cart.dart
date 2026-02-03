import 'product.dart';

class ProductCart extends Product {
  final int count;

  ProductCart({
    required super.id,
    required super.title,
    required super.price,
    required super.gender,
    required super.weight,
    required super.description,
    required this.count,
  });

  factory ProductCart.fromJson(Map <String, dynamic> data) {
    final obj = data['products'];
    return ProductCart(
      id: obj['id'],
      title: obj['title'],
      price: obj['price'],
      gender: obj['gender'],
      weight: obj['weight'].toString(),
      description: obj['description'],
      count: data['count']
    );
  }
}
