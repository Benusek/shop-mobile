import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/services/api.dart';
import 'package:mobile/services/secure_storage.dart';
import 'package:ui/ui.dart';

import '../models/product_cart.dart';
import '../models/user.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late List<ProductCart> carts;
  late Future<void> _future;
  late int counter;
  Api service = Api();
  SecureStorage storage = SecureStorage();

  Future<void> getData() async {
    carts = await service.getCart();
    counter = 0;
    for (var value in carts) {
      counter += value.price * value.count;
    }
  }

  void refreshPage() {
    setState(() {
      _future = getData();
    });
  }

  Future<void> deleteCart() async {
    await service.deleteAllCart();
    refreshPage();
  }

  Future<void> changeCounter(ProductCart product, bool plus) async {
    await service.updateCart(product, plus);
    refreshPage();
  }

  @override
  void initState() {
    super.initState();
    _future = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Color(0xFFF5F5F9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Heading(text: 'Корзина'),
                      IconButton(
                        onPressed: () => deleteCart(),
                        color: Colors.grey,
                        icon: Icon(Icons.restore_from_trash_outlined),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Expanded(
                    flex: 3,
                    child: ListView.builder(
                      itemCount: carts.length,
                      itemBuilder: (context, index) {
                        final ProductCart cart = carts[index];
                        return CartCard(
                          title: cart.title,
                          price: cart.price,
                          count: cart.count,
                          plusFunc: () => changeCounter(cart, true),
                          minusFunc: () => changeCounter(cart, false),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Сумма',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '$counter ₽',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => print('123'),
                      child: Text(
                        'Перейти к оформлению заказа',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
