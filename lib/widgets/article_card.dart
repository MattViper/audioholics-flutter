import 'package:audioholics/providers/article.dart';
import 'package:audioholics/screens/ArticleScreen.dart';
import 'package:audioholics/shared/color_palette.dart';
import 'package:audioholics/widgets/custom_box_shadow.dart';
import 'package:flutter/material.dart';

class ArticleCard extends StatefulWidget {
  final Article _article;

  ArticleCard(this._article);

  @override
  _ArticleCardState createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          CustomBoxShadow(
              color: Colors.black12, offset: Offset(2.0, 1.0), blurRadius: 20.0)
        ],
      ),
      child: Card(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          color: ColorPalette.PrimaryColor,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ArticleScreen(),
                    settings: RouteSettings(arguments: widget._article.slug)),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: FlatButton(
                          color: Colors.white,
                          shape: StadiumBorder(),
                          child: Text(
                            widget._article.category.toUpperCase(),
                            style: TextStyle(
                                color: ColorPalette.PrimaryColor,
                                fontStyle: FontStyle.italic,
                                fontSize: 14.0),
                          ),
                          onPressed: () {},
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        '${widget._article.created.day}-${widget._article.created.month}-${widget._article.created.year}',
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 14.0,
                            fontStyle: FontStyle.italic,
                            color: Colors.white70),
                      ),
                    )
                  ],
                ),
                Row(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget._article.author.avatar)),
                  ),
                  Text(
                    widget._article.author.artistName,
                    style: TextStyle(color: Colors.white),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    widget._article.title,
                    style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
