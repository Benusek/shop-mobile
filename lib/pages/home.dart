import 'package:flutter/material.dart';
import 'package:mobile/models/new.dart';
import 'package:mobile/services/api.dart';
import 'package:ui/ui.dart';

import '../models/product.dart';

class Home extends StatefulWidget {
  final Function(int, String) navigate;

  const Home({super.key, required this.navigate});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  late Future<void> _future;
  int selectedCategory = 0;

  //TODO: Duplicate written
  final List<Map<String, dynamic>> categories = [
    {'title': 'Все', 'code': null},
    {'title': 'Женщинам', 'code': 'female'},
    {'title': 'Мужчинам', 'code': 'male'},
  ];

  late List<Product> cards;
  late List<New> news;

  Future<void> getData(String? category) async {
    cards = await Api().getOrders(category, null);
    news = await Api().getNews();
  }

  @override
  void initState() {
    super.initState();
    _future = getData(null);
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
                //TODO: Prefix and suffix move to package of components
                Input(
                  labelText: 'Искать описания',
                  controller: _searchController,
                  prefix: Icon(Icons.search),
                  submitted: (value) => widget.navigate(1, value!),
                  changed: (value) => setState(() => _searchController.text = value!),
                  suffix: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => setState(() => _searchController.clear()),
                        )
                      : null,
                ),
                SizedBox(height: 32),
                SubTitle(text: 'Акции и новости'),
                SizedBox(height: 16),
                SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: news.length,
                    itemBuilder: (context, index) {
                      return PromoCard(
                        price: '4000 ₽',
                        title: 'Шорты\nВторник',
                        image: 'assets/vaccine.png',
                      );
                    },
                  ),
                ),
                SizedBox(height: 32),
                SubTitle(text: 'Каталог описаний'),
                SizedBox(height: 15),
                //TODO: Move category list to package of components
                SizedBox(
                  height: 48,
                  child: ListView.separated(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Category(
                        func: () => setState(() {
                          selectedCategory = index;
                          _future = getData(categories[selectedCategory]['code']);
                        }),
                        title: categories[index]['title'],
                        isSelected: index == selectedCategory ? true : false,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 16);
                    },
                  ),
                ),
                SizedBox(height: 15),
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
