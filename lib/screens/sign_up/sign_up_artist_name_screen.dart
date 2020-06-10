import 'package:audioholics/models/sign_up_arguments.dart';
import 'package:audioholics/screens/sign_up/sign_up_email_screen.dart';
import 'package:audioholics/shared/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpArtistNameScreen extends StatefulWidget {
  static const routeName = '/signUp-1';

  @override
  _SignUpArtistNameScreenState createState() => _SignUpArtistNameScreenState();
}

class _SignUpArtistNameScreenState extends State<SignUpArtistNameScreen> {
  String artistName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.indigoAccent, ColorPalette.PrimaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                'What\'s your artist name?',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.0,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextFormField(
                onChanged: (value) => artistName = value,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontStyle: FontStyle.italic),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    labelText: 'Your artist name',
                    labelStyle:
                        TextStyle(color: Colors.white70, fontSize: 18.0),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      style: BorderStyle.none,
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      style: BorderStyle.none,
                    ))),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(200, 100, 0, 0),
              child: FlatButton(
                onPressed: () => Navigator.of(context).pushNamed(
                  SignUpEmailScreen.routeName,
                  arguments: SignUpArguments(artistName, ''),
                ),
                child: Text(
                  'Continue',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
