import 'package:audioholics/providers/comment.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatefulWidget {
  final Comment _comment;

  CommentCard(this._comment);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(widget._comment.author.artistName),
          Text(widget._comment.body)
        ],
      ),
    );
  }
}
