import 'package:audioholics/providers/article.dart';
import 'package:audioholics/shared/color_palette.dart';
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
    return Card(
        shadowColor: ColorPalette.PrimaryColor,
        elevation: 10.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: ColorPalette.PrimaryColor,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
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
                            fontSize: 12.0),
                      ),
                      onPressed: () {},
                    )),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    '${widget._article.created.day}-${widget._article.created.month}-${widget._article.created.year}',
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 12.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.white70),
                  ),
                )
              ],
            ),
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
        ));
  }
}
