import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Input(
              labelText: 'Поиск',
              controller: _searchController,
              prefix: Icon(Icons.search),
              changed: (value) =>
                  setState(() => _searchController.text = value!),
              suffix: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => setState(() {
                        _searchController.clear();
                      }),
                    )
                  : null,
            ),
            SizedBox(height: 32),
            SubTitle(text: 'Акции и новости'),
            SizedBox(height: 16),

            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  PromoCard(price: '4000 ₽', title: 'Шорты\nВторник'),
                  PromoCard(price: '4000 ₽', title: 'Шорты\nВторник'),
                ],
              ),
            ),
            SizedBox(height: 32),
            SubTitle(text: 'Каталог описаний'),
            SizedBox(height: 15),
            Text('Категории меню (Мужчинам, Детям и т.д)'),
            Text('Список продуктов'),
          ],
        ),
      ),
    );
  }
}
