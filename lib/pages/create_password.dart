import 'package:flutter/material.dart';
import 'package:mobile/services/api.dart';
import 'package:ui/ui.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  bool hide = true;
  bool hide2 = true;

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 59, 20, 59),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('✋', style: TextStyle(fontSize: 32)),
                  SizedBox(width: 16),
                  Heading(text: 'Создание пароля'),
                ],
              ),
              SizedBox(height: 23),
              Text('Введите новый пароль'),
              SizedBox(height: 90),
              Label(text: 'Новый пароль'),
              Input(
                password: true,
                private: hide,
                suffix: IconButton(
                  icon: Icon(hide ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => hide = !hide),
                  highlightColor: Colors.transparent,
                ),
              ),
              SizedBox(height: 12),
              Label(text: 'Повторите пароль'),
              Input(
                password: true,
                private: hide2,
                suffix: IconButton(
                  icon: Icon(hide2 ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => hide2 = !hide2),
                  highlightColor: Colors.transparent,
                )
              ),
              SizedBox(height: 12),
              CompletedButton(
                text: 'Сохранить',
                func: () {
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
