import 'package:audioholics/models/http_exception.dart';
import 'package:audioholics/models/sign_up_arguments.dart';
import 'package:audioholics/providers/auth.dart';
import 'package:audioholics/screens/sign_up/sign_up_email_screen.dart';
import 'package:audioholics/shared/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpArtistNameScreen extends StatefulWidget {
  static const routeName = '/signUp-1';

  @override
  _SignUpArtistNameScreenState createState() => _SignUpArtistNameScreenState();
}

class _SignUpArtistNameScreenState extends State<SignUpArtistNameScreen> {
  String artistName;
  final _formKey = GlobalKey<FormState>();

  String _validateArtistName(String artistName) {
    if (artistName.isEmpty) {
      return 'Artist name cannot be empty!';
    }
    if (Provider.of<Auth>(context, listen: false).artistNameExists) {
      return 'Artist name already exists!';
    } else
      return null;
  }

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
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextFormField(
                  validator: (value) => _validateArtistName(value),
                  onChanged: (value) => artistName = value,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontStyle: FontStyle.italic),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      errorStyle:
                          TextStyle(color: Colors.amber, fontSize: 16.0),
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
            ),
            SizedBox(
              height: 50,
            ),
            Consumer<Auth>(
              builder: (ctx, authData, _) => Padding(
                padding: const EdgeInsets.fromLTRB(200, 100, 0, 0),
                child: FlatButton(
                  onPressed: () async {
                    try {
                      await Provider.of<Auth>(context, listen: false)
                          .checkArtistName(artistName);
                      if (_formKey.currentState.validate()) {
                        if (authData.artistNameExists == false) {
                          Navigator.of(context).pushNamed(
                            SignUpEmailScreen.routeName,
                            arguments: SignUpArguments(artistName, ''),
                          );
                        }
                      }
                    } on HttpException catch (error) {
                      throw error;
                    }
                  },
                  child: Text(
                    'Continue',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
