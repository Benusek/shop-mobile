import 'dart:convert';

import 'package:mobile/models/user.dart';
import 'package:mobile/models/product_cart.dart';
import 'package:mobile/models/new.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/services/secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

class Api {
  final supabase = Supabase.instance.client;
  final secureStorage = SecureStorage();

  Future<dynamic>? auth(String email, String pass) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: pass,
      );

      final Session? session = res.session;
      final user = await supabase.from('users').select().limit(1).single();

      await secureStorage.writeSecureData('token', session!.accessToken);
      await secureStorage.writeSecureData('user.data', jsonEncode(user));
    } on AuthException catch (error) {
      print(error.message);
    }
  }

  void logout() async {
    await supabase.auth.signOut();
    secureStorage.deleteAllData();
  }

  void register(
      Map<String, dynamic> data,
      String email,
      String password,
      ) async {
    print(data);
    print(email);
    print(password);
    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      final Session? session = res.session;
      final user = res.user;
      if (user == null) return;
      data['id'] = user.id;
      await supabase.from('users').insert(data);
      print(session);
      // final User? user = res.user;
    } on Exception catch (error) {
      print(error);
    }
  }

  Future<List<Product>> getProducts(String? gender, String? query) async {
    var builder = supabase.from('products').select();
    if (gender != null) {
      builder = builder.eq('gender', gender);
    }
    if (query != null) {
      builder = builder.ilike('title', '%$query%');
    }
    final response = await builder;
    final List<Product> products = response
        .map((json) => Product.fromJson(json))
        .toList();

    final PostgrestList responseCart = await supabase
        .from('cart')
        .select('count, products(id, title, price, gender, description, weight)');
    final List<ProductCart> carts = responseCart
        .map((json) => ProductCart.fromJson(json))
        .toList();

    final List<String> ids = carts.map((obj)=> obj.id).toList();
    for (var value in products) {
      if (ids.contains(value.id)) {
        value.added = true;
      }
    }
    return products;
  }

  Future<void> storeProductCart(Product product) async {
    SecureStorage storage = SecureStorage();
    final String? str = await storage.readSecureData('user.data');
    if (str != null) {
      final User user = User.fromJson(json.decode(str));
      await supabase.from('cart').insert({
        'user_id': user.id,
        'product_id': product.id,
        'count': 1,
      });
    }
  }

  Future<void> deleteProductCart(Product product) async {
    SecureStorage storage = SecureStorage();
    final String? str = await storage.readSecureData('user.data');
    if (str != null) {
      final User user = User.fromJson(json.decode(str));
      await supabase.from('cart').delete().match({
        'user_id': user.id,
        'product_id': product.id,
      });
    }
  }

  Future<List<New>> getNews() async {
    final PostgrestList response = await supabase.from('news').select();
    final List<New> news = response.map((json) => New.fromJson(json)).toList();
    return news;
  }

  Future<List<ProductCart>> getCart() async {
    final PostgrestList response = await supabase
        .from('cart')
        .select(
      'count, products(id, title, price, gender, description, weight)',
    );
    final List<ProductCart> carts = response
        .map((json) => ProductCart.fromJson(json))
        .toList();
    return carts;
  }

  Future<void> updateCart(ProductCart product, bool plus) async {
    SecureStorage storage = SecureStorage();
    final String? str = await storage.readSecureData('user.data');
    if (str != null) {
      if (product.count > 1 || product.count < 2 && plus) {
        final User user = User.fromJson(json.decode(str));
        await supabase
            .from('cart')
            .update({'count': plus ? product.count + 1 : product.count - 1})
            .match({'product_id': product.id, 'user_id': user.id})
            .select()
            .single();
      }
    }
  }

  Future<void> deleteAllCart() async {
    SecureStorage storage = SecureStorage();
    final String? str = await storage.readSecureData('user.data');
    if (str != null) {
      final User user = User.fromJson(json.decode(str));
      await supabase.from('cart').delete().eq('user_id', user.id);
    }
  }

  Future<void> storeCart(Map<String, dynamic> data) async {
    SecureStorage storage = SecureStorage();
    final String? str = await storage.readSecureData('user.data');
    if (str != null) {
      final User user = User.fromJson(json.decode(str));
      final response = await supabase.from('cart').insert(data);
      print(response);
    }
  }
}
