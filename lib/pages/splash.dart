import 'package:flutter/material.dart';
import 'package:mobile/services/secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  void setupApp() async {
    await Future.delayed(Duration(seconds: 3));
    await Supabase.initialize(
      url: 'https://snjydmmwfxsjsawunbsm.supabase.co',
      anonKey: 'sb_publishable_9XoDcC3UdA-ClIjsHH6oUA_HNZYgm9N',
    );

    String? data = await SecureStorage().readSecureData('user.data');
    if (data != null) {
      if (mounted) Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    }
    else {
      if (mounted) Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  void initState() {
    super.initState();
    setupApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2254F5),
      body: Stack(
        children: [
          Image.asset('assets/bg.png', fit: BoxFit.cover, width: double.infinity),
          Center(
            child: Text('Malture', style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              letterSpacing: 1.04
            )),
          )
        ],
      )
    );
  }
}
