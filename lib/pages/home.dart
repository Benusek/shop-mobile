import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  int selectedCategory = 0;
  //TODO: Duplicate written
  final List<String> categories = ['Все', 'Женщинам', 'Мужчинам'];

  @override
  Widget build(BuildContext context) {
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
                  PromoCard(
                    price: '4000 ₽',
                    title: 'Шорты\nВторник',
                    image: 'assets/vaccine.png',
                  ),
                  PromoCard(price: '4000 ₽', title: 'Шорты\nВторник'),
                ],
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
                    func: () => setState(() => selectedCategory = index),
                    title: categories[index],
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
              child: ListView.separated(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: double.infinity,
                    child: CardOrder(
                      gender: 'female',
                      title: 'Рубашка Воскресенье для машинного вязания',
                      price: '${300 * index} ₽',
                      added: true
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 16);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
