import 'package:flutter/foundation.dart';

class Article with ChangeNotifier {
  final int id;
  final String title;
  final String description;
  final String announcement;
  final String content;
  //Author
  final int points;

  Article(
      {this.id,
      @required this.title,
      @required this.description,
      @required this.announcement,
      @required this.content,
      @required this.points});
}
