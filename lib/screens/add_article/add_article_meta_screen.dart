import 'package:audioholics/models/add_article_arguments.dart';
import 'package:audioholics/screens/add_article/add_article_body_screen.dart';
import 'package:audioholics/shared/color_palette.dart';
import 'package:flutter/material.dart';

class AddArticleMetaScreen extends StatefulWidget {
  static const routeName = '/add-article-meta';

  @override
  _AddArticleMetaScreenState createState() => _AddArticleMetaScreenState();
}

class _AddArticleMetaScreenState extends State<AddArticleMetaScreen> {
  var _title;
  var _description;
  var _category;

  final _formKey = GlobalKey<FormState>();

  String _validateField(String field) {
    if (field.isEmpty) {
      return 'Field cannot be empty!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Center(
                child: Text(
                  'New Article',
                  style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w700,
                      color: ColorPalette.PrimaryColor),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onChanged: (value) => _title = value,
                      validator: (value) => _validateField(value),
                      decoration: InputDecoration(
                        errorStyle:
                            TextStyle(color: Colors.red, fontSize: 16.0),
                        labelStyle: TextStyle(color: Colors.grey),
                        labelText: 'Title',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorPalette.PrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onChanged: (value) => _description = value,
                      validator: (value) => _validateField(value),
                      decoration: InputDecoration(
                        errorStyle:
                            TextStyle(color: Colors.red, fontSize: 16.0),
                        labelStyle: TextStyle(color: Colors.grey),
                        labelText: 'Description',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorPalette.PrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onChanged: (value) => _category = value,
                      validator: (value) => _validateField(value),
                      decoration: InputDecoration(
                        errorStyle:
                            TextStyle(color: Colors.red, fontSize: 16.0),
                        labelStyle: TextStyle(color: Colors.grey),
                        labelText: 'Category',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorPalette.PrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(200, 100, 20, 50),
              child: FlatButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Navigator.of(context).pushNamed(
                        AddArticleBodyScreen.routeName,
                        arguments: AddArticleArguments(
                            _title, _description, _category));
                  }
                },
                child: Text(
                  'Write content',
                  style: TextStyle(
                      color: ColorPalette.PrimaryColor,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
