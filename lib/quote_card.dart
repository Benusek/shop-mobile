import 'quote.dart';
import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;
  final Function()? delete;
  const QuoteCard({
    super.key, required this.quote, required this.delete
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.blue,
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quote.author,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                      quote.text,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1
                      )
                  ),
                ],
              ),
              IconButton(
                onPressed: delete,
                style: TextButton.styleFrom(
                  iconColor: Colors.red,
                  backgroundColor: Colors.white,
                ),
                icon: Icon(Icons.delete),
              )
            ],
          ),
        )
    );
  }
}