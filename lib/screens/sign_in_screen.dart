import 'dart:ui';

import 'package:audioholics/shared/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Widget _title() {
    return Text(
      'audioholics',
      style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.w900,
          color: ColorPalette.PrimaryColor),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                labelText: title,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff6c63fF)),
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ))
        ],
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email"),
        _entryField("Password", isPassword: true),
      ],
    );
  }

  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      child: RaisedButton(
        color: ColorPalette.PrimaryColor,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(50.0)),
        onPressed: () {},
        child: Text(
          'SIGN IN',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return Container(
      height: 100,
      width: 75,
      child: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.facebookF,
            color: Colors.blue,
          ),
          onPressed: null),
    );
  }

  Widget _googleButton() {
    return Container(
      height: 100,
      width: 75,
      child: IconButton(
        icon: FaIcon(
          FontAwesomeIcons.google,
          color: Colors.red,
        ),
        onPressed: null,
      ),
    );
  }

  Widget _twitterButton() {
    return Container(
      height: 100,
      width: 75,
      child: IconButton(
        icon: FaIcon(
          FontAwesomeIcons.twitter,
          color: Colors.lightBlue,
        ),
        onPressed: null,
      ),
    );
  }

  Widget _socialSignIn() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _facebookButton(),
          _googleButton(),
          _twitterButton()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: SizedBox(),
                  ),
                  _title(),
                  SizedBox(
                    height: 50,
                  ),
                  _emailPasswordWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  _submitButton(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: Text('Forgot Password ?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                  ),
                  _divider(),
                  _socialSignIn(),
                  Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
