import 'package:audioholics/providers/articles.dart';
import 'package:audioholics/shared/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class ArticleScreen extends StatefulWidget {
  static const routeName = '/article';

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  Future<void> _fetchArticle(BuildContext context) async {
    final slug = ModalRoute.of(context).settings.arguments as String;
    await Provider.of<Articles>(context, listen: false).findById(slug);
  }

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return FutureBuilder(
      future: _fetchArticle(context),
      builder: (BuildContext context, AsyncSnapshot snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : Consumer<Articles>(
                  builder: (ctx, articlesData, _) => Scaffold(
                        body: Container(
                          child: SingleChildScrollView(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: Text(
                                    articlesData.currentArticle.title,
                                    style: TextStyle(
                                        color: ColorPalette.PrimaryColor,
                                        fontSize: 32.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: Text(
                                    articlesData.currentArticle.description,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: Html(
                                      data: articlesData.currentArticle.body),
                                ),
                              ])),
                        ),
                      )),
    );
  }
}
