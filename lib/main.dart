import 'package:flutter/material.dart';
import 'quote.dart';
import 'quote_card.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Quote> quotes = [
    Quote(author: 'egor', text: 'My name is Egor'),
    Quote(author: 'egor', text: 'I have nothing'),
    Quote(author: 'alex', text: 'My lose equal is little win')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('List of quotes',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        )),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: quotes.map((quote) => QuoteCard(
          quote: quote,
          delete: () {
            setState(() {
              quotes.remove(quote);
            });
          }
        )).toList(),
      )
    );
  }
}


