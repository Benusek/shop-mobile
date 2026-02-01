import 'package:flutter/material.dart';
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
    cards = await Api().getOrders(category, query);
  }

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
                          _future = getData(categories[selectedCategory]['code'], _searchController.text);
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
                          _future = getData(categories[selectedCategory]['code'], _searchController.text);
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
                  child: ListView.builder(
                    itemCount: cards.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: CardOrder(
                            cardFunc: () => print('hello, me is order'),
                            gender: cards[index].gender,
                            title: cards[index].title,
                            price: '${cards[index].price} ₽',
                            added: true,
                          ),
                        ),
                      );
                    },
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
