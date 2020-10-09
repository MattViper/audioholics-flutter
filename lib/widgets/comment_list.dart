import 'package:audioholics/providers/comments.dart';
import 'package:audioholics/shared/color_palette.dart';
import 'package:audioholics/widgets/comment_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentList extends StatefulWidget {
  final String _articleSlug;

  CommentList(this._articleSlug);

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  Future<void> _refreshComments(BuildContext context) async {
    await Provider.of<Comments>(context, listen: false)
        .fetchComments(widget._articleSlug);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: FutureBuilder(
          future: _refreshComments(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(child: CircularProgressIndicator())
                  : Consumer<Comments>(
                      builder: (ctx, commentsData, _) => Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            'Comments',
                            style: TextStyle(
                                color: ColorPalette.PrimaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 24.0),
                          ),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8),
                              itemCount: commentsData.comments.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  child: commentsData.comments.length > 0
                                      ? new CommentCard(
                                          commentsData.comments[index])
                                      : Text(
                                          'No comments.',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                );
                              })
                        ],
                      ),
                    ),
        ));
  }
}
