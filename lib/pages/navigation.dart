import 'package:flutter/material.dart';
import 'package:mobile/pages/home.dart';
import 'package:mobile/pages/catalog.dart';
import 'package:mobile/pages/profile.dart';
import 'package:mobile/pages/projects.dart';
import 'package:ui/ui.dart';

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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[50],
      body: [Home(), Catalog(), Projects(), Profile()][_currentIndex],
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.all(0),
        color: Colors.white,
        child: TabNavigation(
          selectedIndex: _currentIndex,
          func: (index) => setState(() => _currentIndex = index),
          items: items,
        ),
      ),
    );
  }
}
