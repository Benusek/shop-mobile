import 'package:flutter/material.dart';
import 'package:mobile/pages/home.dart';
import 'package:mobile/pages/catalog.dart';
import 'package:mobile/pages/profile.dart';
import 'package:mobile/pages/projects.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;

  List<Map<String, dynamic>> items = [
    {'title': 'Главная', 'icon': Icons.home_outlined},
    {'title': 'Каталог', 'icon': Icons.newspaper_outlined},
    {'title': 'Проекты', 'icon': Icons.task_outlined},
    {'title': 'Профиль', 'icon': Icons.person_outline},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: [Home(), Catalog(), Projects(), Profile()][_currentIndex],
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.all(0),
        color: Colors.white,
        child: Row(
            children: List.generate(items.length, (index) {
            return Expanded(
              child: InkWell(
                onTap: () {
                  setState(() => _currentIndex = index);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      items[index]['icon'],
                      color: _currentIndex == index
                          ? Colors.blueAccent
                          : Colors.grey,
                    ),
                    Text(
                      items[index]['title'],
                      style: TextStyle(
                        fontSize: 12,
                        color: _currentIndex == index
                            ? Colors.blueAccent
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
