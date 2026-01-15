import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home()
  ));
}


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('First app',
      //   style: TextStyle(
      //     color: Colors.white,
      //     fontWeight: FontWeight.bold,
      //   )),
      //   centerTitle: true,
      // create variable for 0xFF1A6FEE
      //   backgroundColor: Color(0xFF1A6FEE),
      // ),
      body: Center(
        child: Image.network('https://i.pinimg.com/1200x/48/86/d9/4886d9fa6fcee448eee9328c651c33c8.jpg'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Text('click')
      ),
    );
  }
}
