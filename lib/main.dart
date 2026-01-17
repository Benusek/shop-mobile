import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int level = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: Text(
          'First app',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        // create variable for 0xFF1A6FEE
        backgroundColor: Color(0xFF1A6FEE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/logo.png'),
                radius: 40,
              ),
            ),
            Divider(height: 60, color: Colors.blue[700]),
            Text(
              'NAME',
              style: TextStyle(letterSpacing: 2, color: Colors.white54),
            ),
            Text(
              'Егор',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 28,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'CURRENT LEVEL',
              style: TextStyle(letterSpacing: 2, color: Colors.white54),
            ),
            Text(
              '$level',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 28,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.email, color: Colors.white70),
                SizedBox(width: 10),
                Text(
                  'remizov.egg@gmail.com',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            level += 1;
          });
        },
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        child: Icon(Icons.add, color: Colors.blueAccent),
      ),
    );
  }
}
