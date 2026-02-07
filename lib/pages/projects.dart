import 'package:flutter/material.dart';
import 'package:mobile/models/project.dart';
import 'package:mobile/services/api.dart';
import 'package:ui/custom_color.dart';
import 'package:ui/ui.dart';
import 'package:get_time_ago/get_time_ago.dart';

class Projects extends StatefulWidget {
  final Function(int) navigate;
  const Projects({super.key, required this.navigate});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {

  List<Project>? projects;
  Api service = Api();
  late Future<void> _future;

  Future<void> getData() async{
    projects = await service.getProject();
  }

  @override
  void initState() {
    super.initState();
    _future = getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

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
                      onPressed: () => widget.navigate(4),
                      color: CustomColor.inputStr
                    )
                  ],
                ),
                SizedBox(height: 36),
                Expanded(
                  child: ListView.builder(
                    itemCount: projects!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final card = projects![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: CardProject(
                            title: card.title,
                            date: GetTimeAgo.parse(DateTime.parse(card.datestart), locale: 'ru'),
                            cardFunc: () => print('hi, me is card'),
                            func: () {},
                            buttonTitle: 'Открыть',
                          ),
                        ),
                      );
                    }
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
