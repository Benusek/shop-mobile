import 'package:flutter/material.dart' hide BottomSheet;
import 'package:mobile/services/api.dart';
import 'package:ui/ui.dart';
import '../models/product.dart';

class Catalog extends StatefulWidget {
  final Function(int) navigate;
  final String? query;

  const Catalog({super.key, required this.navigate, this.query});

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  final TextEditingController _searchController = TextEditingController();
  late List<Product> cards;
  late int sum = 0;
  final Api service = Api();

  //TODO: Duplicate written
  final List<Map<String, dynamic>> categories = [
    {'title': 'Все', 'code': null},
    {'title': 'Женщинам', 'code': 'female'},
    {'title': 'Мужчинам', 'code': 'male'},
  ];
  int selectedCategory = 0;
  Future<void>? _future;

  @override
  void initState() {
    super.initState();
    if (widget.query != null) {
      _searchController.text = widget.query!;
    }
    _future = getData(null, widget.query);
  }

  Future<void> getData(String? category, String? query) async {
    cards = await service.getProducts(category, query);

    for (var value in cards) {
      if (value.added) {
        sum += value.price;
      }
    }
  }

  Future<void> storeProductCart(Product product) async {
    await service.storeProductCart(product);
    // refreshPage();
  }

  Future<void> removeProductCart(Product product) async {
    await service.deleteProductCart(product);
    // refreshPage();
  }

  // void refreshPage() {
  //   setState(() {
  //     _future = getData(categories[selectedCategory]['code'], widget.query);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //TODO: Duplicate written
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.70,
                      child: Input(
                        labelText: 'Искать описания',
                        controller: _searchController,
                        prefix: Icon(Icons.search),
                        submitted: (value) {
                          setState(() => _searchController.text = value!);
                          _future = getData(
                            categories[selectedCategory]['code'],
                            _searchController.text,
                          );
                        },
                        suffix: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () => _searchController.clear(),
                              )
                            : null,
                      ),
                    ),
                    IconButton(
                      icon: Image.asset('assets/user_icon.png'),
                      onPressed: () => widget.navigate(3),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                //TODO: Move category list to package of components
                SizedBox(
                  height: 48,
                  child: ListView.separated(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Category(
                        func: () {
                          setState(() => selectedCategory = index);
                          _future = getData(
                            categories[selectedCategory]['code'],
                            _searchController.text,
                          );
                        },
                        title: categories[index]['title'],
                        isSelected: index == selectedCategory ? true : false,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 16);
                    },
                  ),
                ),
                SizedBox(height: 20),
                //TODO: Move category list to package of components
                Expanded(
                  child: Stack(
                    children: [
                      ListView.builder(
                        itemCount: cards.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Product card = cards[index];
                          return SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6.0,
                              ),
                              child: CardOrder(
                                buttonFunc: removeProductCart(cards[index]),
                                cardFunc: () => showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  context: context,
                                  builder: (context) {
                                    return BottomSheet(
                                      title: card.title,
                                      description: card.description,
                                      weight: card.weight,
                                      price: card.price,
                                    );
                                  },
                                ),
                                gender: card.gender,
                                title: card.title,
                                price: '${card.price} ₽',
                                added: card.added,
                              ),
                            ),
                          );
                        },
                      ),
                      ?sum != 0 ? Positioned(
                        right: 0,
                        left: 0,
                        bottom: 32,
                        child: SizedBox(
                          height: 56,
                          child: FilledButton(
                            onPressed: () => Navigator.of(context).pushNamed('/cart'),
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              textStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600
                              )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.shopping_cart_outlined),
                                    SizedBox(width: 16),
                                    Text('В корзину'),
                                  ],
                                ),
                                Text('$sum ₽')
                              ],
                            ),
                          ),
                        ),
                      ):null,
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
