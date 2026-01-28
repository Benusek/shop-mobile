import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Center(child: Heading(text: 'Проекты'))),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                  color: Color(0xFFB8C1CC)
                )
              ],
            ),
            SizedBox(height: 36),
            Expanded(
              child: ListView.separated(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: double.infinity,
                    child: CardProject(
                      func: () {},
                      buttonTitle: 'Открыть',
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 16);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
