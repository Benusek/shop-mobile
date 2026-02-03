import 'product.dart';

class Carts extends Product {
  final String count;

  Carts({
    required super.id,
    required super.title,
    required super.price,
    required super.gender,
    required super.weight,
    required super.description,
    required this.count,
  });

  factory Carts.fromJson(Map <String, dynamic> data) {
    final obj = data['products'];
    return Carts(
      id: obj['id'],
      title: obj['title'],
      price: obj['price'],
      gender: obj['gender'],
      weight: obj['weight'],
      description: obj['description'],
      count: data['count']
    );
  }
}
