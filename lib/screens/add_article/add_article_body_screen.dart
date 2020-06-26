import 'package:audioholics/models/add_article_arguments.dart';
import 'package:flutter/material.dart';

class AddArticleBodyScreen extends StatefulWidget {
  static const routeName = '/add-article-body';

  @override
  _AddArticleBodyScreenState createState() => _AddArticleBodyScreenState();
}

class _AddArticleBodyScreenState extends State<AddArticleBodyScreen> {
  @override
  Widget build(BuildContext context) {
    AddArticleArguments args = ModalRoute.of(context).settings.arguments;
    var _title = args.title;
    var _description = args.description;
    var _category = args.category;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[],
        ),
      ),
    );
  }
}
