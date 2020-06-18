import 'package:audioholics/models/sign_up_arguments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPasswordScreen extends StatefulWidget {
  static const routeName = '/signUp-3';

  @override
  _SignUpPasswordScreenState createState() => _SignUpPasswordScreenState();
}

class _SignUpPasswordScreenState extends State<SignUpPasswordScreen> {
  String password;

  @override
  Widget build(BuildContext context) {
    final SignUpArguments args = ModalRoute.of(context).settings.arguments;
    final String _artistName = args.artistName;
    final String _email = args.email;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.pink, Colors.amber[700]],
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
                'Finally, set your account password',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.0,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextFormField(
                onChanged: (value) => password = value,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontStyle: FontStyle.italic),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    labelText: 'Your password',
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
              padding: const EdgeInsets.fromLTRB(200, 75, 0, 0),
              child: FlatButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed(SignUpPasswordScreen.routeName),
                child: Text(
                  'Create account',
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
