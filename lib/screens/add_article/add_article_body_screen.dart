import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:audioholics/models/add_article_arguments.dart';
import 'package:audioholics/providers/article.dart';
import 'package:audioholics/providers/articles.dart';
import 'package:audioholics/shared/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

import '../home_feed_screen.dart';

class AddArticleBodyScreen extends StatefulWidget {
  static const routeName = '/add-article-body';

  @override
  _AddArticleBodyScreenState createState() => _AddArticleBodyScreenState();
}

class _AddArticleBodyScreenState extends State<AddArticleBodyScreen> {
  ZefyrController _controller;

  FocusNode _focusNode;
  bool _editing = false;
  StreamSubscription<NotusChange> _sub;

  @override
  void initState() {
    super.initState();
    final document = _loadDocument();
    _controller = ZefyrController(document);
    _focusNode = FocusNode();
    _sub = _controller.document.changes.listen((change) {
      print('${change.source}: ${change.change}');
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AddArticleArguments args = ModalRoute.of(context).settings.arguments;
    final String _title = args.title;
    final String _description = args.description;
    final String _category = args.category;

    final theme = new ZefyrThemeData(
      toolbarTheme: ToolbarTheme.fallback(context).copyWith(
          color: ColorPalette.PrimaryColor,
          toggleColor: Colors.indigo,
          iconColor: Colors.white,
          disabledIconColor: Colors.grey.shade500),
    );

    _submit() {
      try {
        final body = jsonEncode(_controller.document);
        Provider.of<Articles>(context, listen: false).addArticle(Article.add(
            title: _title,
            description: _description,
            category: _category,
            body: body));
      } catch (error) {
        throw error;
      }
      Navigator.of(context).popAndPushNamed(HomeFeedScreen.routeName);
    }

    final done = new FlatButton(
        onPressed: () => _submit(),
        child: Text(
          'DONE',
          style: TextStyle(color: Colors.white),
        ));

    return Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          backgroundColor: ColorPalette.PrimaryColor,
          brightness: Brightness.light,
          title: Text(
            'Write content',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[done],
        ),
        body: ZefyrScaffold(
          child: ZefyrTheme(
            data: theme,
            child: ZefyrEditor(
              padding: EdgeInsets.all(16.0),
              controller: _controller,
              focusNode: _focusNode,
              imageDelegate: new CustomImageDelegate(),
            ),
          ),
        ));
  }

  NotusDocument _loadDocument() {
    final Delta delta = Delta()..insert('\n');
    return NotusDocument.fromDelta(delta);
  }
}

class CustomImageDelegate extends ZefyrImageDelegate<ImageSource> {
  ImagePicker imagePicker = new ImagePicker();
  @override
  Widget buildImage(BuildContext context, String key) {
    final file = File.fromUri(Uri.parse(key));

    /// Create standard [FileImage] provider. If [key] was an HTTP link
    /// we could use [NetworkImage] instead.
    final image = FileImage(file);
    return Image(image: image);
  }

  @override
  get cameraSource => ImageSource.camera;

  @override
  get gallerySource => ImageSource.gallery;

  @override
  Future<String> pickImage(ImageSource source) async {
    final file = await imagePicker.getImage(source: source);
    if (file == null) return null;
    // We simply return the absolute path to selected file.
    return file.path;
  }
}
