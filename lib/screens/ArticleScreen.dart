import 'package:audioholics/providers/articles.dart';
import 'package:audioholics/screens/add_comment_screen.dart';
import 'package:audioholics/shared/color_palette.dart';
import 'package:audioholics/widgets/clap_fab.dart';
import 'package:audioholics/widgets/comment_list.dart';
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
    final slug = ModalRoute.of(context).settings.arguments as String;

    return FutureBuilder(
      future: _fetchArticle(context),
      builder: (BuildContext context, AsyncSnapshot snapshot) => snapshot
                  .connectionState ==
              ConnectionState.waiting
          ? Center(child: CircularProgressIndicator())
          : Consumer<Articles>(
              builder: (ctx, articlesData, _) => Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endFloat,
                floatingActionButton: ClapFAB(
                  slug: articlesData.currentArticle.slug,
                ),
                body: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            articlesData.currentArticle.title,
                            style: TextStyle(
                                color: ColorPalette.PrimaryColor,
                                fontSize: 32.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              articlesData.currentArticle.author
                                                  .avatar)),
                                    ),
                                    Text(articlesData
                                        .currentArticle.author.artistName),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    articlesData.currentArticle.points
                                            .toString() +
                                        ' points',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14.0),
                                  ),
                                )
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            articlesData.currentArticle.description,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Html(data: articlesData.currentArticle.body),
                        ),
                        Column(children: <Widget>[
                          CommentList(articlesData.currentArticle.slug),
                          Center(
                            child: FlatButton(
                              onPressed: () => {
                                Navigator.of(context).pushNamed(
                                    AddCommentScreen.routeName,
                                    arguments: slug)
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Text(
                                'Add Comment',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              color: ColorPalette.PrimaryColor,
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
