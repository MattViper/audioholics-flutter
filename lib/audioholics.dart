import 'package:flutter/material.dart';

import 'screens/sign_in_screen.dart';

class Audioholics extends StatelessWidget {
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



