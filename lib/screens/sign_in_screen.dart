import 'dart:ui';

import 'package:audioholics/models/http_exception.dart';
import 'package:audioholics/providers/auth.dart';
import 'package:audioholics/shared/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

String emailFieldValidator(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(value)) ? 'Not a valid email' : null;
}


class PasswordFieldValidator{
  static String validate(String value)
  {
    return (value.isEmpty || value.length < 8)?  'Password is too short' : null;

  }

}

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key key}) : super(key: key);

  static const routeName = '/signIn';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  var _isLoading = false;
  var _email;
  var _password;

  Future<void> _submit() async {

    try {
      await Provider.of<Auth>(context, listen: false).login(_email, _password);
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';

      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

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
          TextFormField(
            keyboardType:  isPassword == false ? TextInputType.emailAddress : TextInputType.text,
            validator: isPassword == true ? PasswordFieldValidator.validate : emailFieldValidator,
            obscureText: isPassword,
            decoration: InputDecoration(
              labelText: title,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff6c63fF)),
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            onChanged: (String value) {
              isPassword == true ? _password = value : _email = value;
            },
            onSaved: (String value) {
              isPassword == true ? _password = value : _email = value;

            },
          )
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
        onPressed: () {
          _submit();
        },
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
