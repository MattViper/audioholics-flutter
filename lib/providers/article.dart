import 'package:flutter/foundation.dart';

class Article with ChangeNotifier {
   int id;
   String title;
   String description;
   String announcement;
   String content;
  //Author
  final int points;

  Article(
      {this.id,
      @required this.title,
      @required this.description,
      @required this.announcement,
      @required this.content,
      @required this.points});

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    announcement = json['imageArray'].cast<String>();
  }
}
