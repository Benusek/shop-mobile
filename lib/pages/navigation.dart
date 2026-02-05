import 'package:flutter/material.dart';
import 'package:mobile/pages/create_project.dart';
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
  int _selectedIndex = 0;
  String? query;

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
      body: [Home(
        navigate: (int index, String value) {
          setState(() {
            query = value;
            _currentIndex = index;
          });
      }), Catalog(
        query: query,
        navigate: (int index) => setState(() => _currentIndex = index)
      ), Projects(
        navigate: (int index) => setState(() {_currentIndex = 4; _selectedIndex = 2;})
      ), Profile(), CreateProject()][_currentIndex],
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.all(0),
        color: Colors.white,
        child: TabNavigation(
          selectedIndex: _selectedIndex,
          func: (index) => setState(() {_currentIndex = index; _selectedIndex = index;}),
          items: items,
        ),
      ),
    );
  }
}
