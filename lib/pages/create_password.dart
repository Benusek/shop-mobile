import 'package:flutter/material.dart';
import 'package:mobile/services/api.dart';
import 'package:ui/ui.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  final GlobalKey<FormState> _formGlobalKey = GlobalKey();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _passConf = TextEditingController();
  bool hide = true;
  bool hide2 = true;

  // TODO: Not filled of red background with validation
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String email = data['email']!;
    print('Data in password screen: $data');
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
              Form(
                key: _formGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Label(text: 'Новый пароль'),
                    Input(
                      validator: (value) {
                        if (value != _passConf.text) {
                          return 'Password do not match.';
                        }
                        return null;
                      },
                      saved: (value) {
                        _pass.text = value!;
                      },
                      controller: _pass,
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
                      validator: (value) {
                        if (value != _pass.text) {
                          return 'Password do not match.';
                        }
                        return null;
                      },
                      controller: _passConf,
                      password: true,
                      private: hide2,
                      suffix: IconButton(
                        icon: Icon(hide2 ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => hide2 = !hide2),
                        highlightColor: Colors.transparent,
                      )
                    ),
                  ],
                )
              ),

              SizedBox(height: 12),
              CompletedButton(
                text: 'Сохранить',
                func: () {
                  if (_formGlobalKey.currentState!.validate()) {
                    _formGlobalKey.currentState!.save();
                    Api().register(data, email, _pass.text);
                    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
