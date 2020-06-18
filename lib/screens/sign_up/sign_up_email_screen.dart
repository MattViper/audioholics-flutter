import 'package:audioholics/models/sign_up_arguments.dart';
import 'package:audioholics/screens/sign_up/sign_up_password_screen.dart';
import 'package:audioholics/shared/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpEmailScreen extends StatefulWidget {
  static const routeName = '/signUp-2';

  @override
  _SignUpEmailScreenState createState() => _SignUpEmailScreenState();
}

class _SignUpEmailScreenState extends State<SignUpEmailScreen> {
  String _email;

  @override
  Widget build(BuildContext context) {
    final SignUpArguments args = ModalRoute.of(context).settings.arguments;
    final _artistName = args.artistName;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [ColorPalette.PrimaryColor, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                'Hello $_artistName!',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.0,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                'What\'s your email?',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.0,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextFormField(
                onChanged: (value) => _email = value,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontStyle: FontStyle.italic),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    labelText: 'Your email',
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
                  SignUpPasswordScreen.routeName,
                  arguments: SignUpArguments(_artistName, _email),
                ),
                child: Text(
                  'Set password',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 20.0,
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
