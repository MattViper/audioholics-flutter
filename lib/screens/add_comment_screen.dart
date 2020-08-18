import 'package:audioholics/providers/comments.dart';
import 'package:audioholics/shared/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCommentScreen extends StatefulWidget {
  static const routeName = '/add-comment';

  @override
  _AddCommentScreenState createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {
  String body = '';
  @override
  Widget build(BuildContext context) {
    String slug = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                    child: Text(
                      'Add comment',
                      style: TextStyle(
                          color: ColorPalette.PrimaryColor,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        labelText: 'Your comment',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorPalette.PrimaryColor,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onChanged: (String value) {
                        body = value;
                      },
                    ),
                  ),
                  FlatButton(
                    onPressed: () => {
                      Provider.of<Comments>(context, listen: false)
                          .addComment(slug, body),
                      Navigator.of(context).pop(),
                    },
                    child: Text('Submit'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
