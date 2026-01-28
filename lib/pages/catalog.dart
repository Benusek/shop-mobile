import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class Catalog extends StatefulWidget {
  const Catalog({super.key});

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> categories = ['Все', 'Женщинам', 'Мужчинам'];
  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
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
                ),
                IconButton(icon: Image.asset('assets/user_icon.png'), onPressed: () {}),
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
            SizedBox(height: 20),
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
                      added: false,
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
