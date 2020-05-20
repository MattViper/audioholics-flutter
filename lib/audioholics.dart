import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'screens/sign_in_screen.dart';

class Audioholics extends StatelessWidget {
    final _storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'audioholics',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primaryColor: Color(0xff6c63fF),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignInScreen(),
    );
  }
}



