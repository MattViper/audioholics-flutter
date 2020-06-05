import 'package:flutter/foundation.dart';

class Article with ChangeNotifier {
  int id;
  String slug;
  String title;
  String description;
  String body;
  String category;
  DateTime created;
  DateTime updated;

  //Author
  int points;

  Article(
      {this.id,
      @required this.slug,
      @required this.title,
      @required this.description,
      @required this.body,
      @required this.category,
      @required this.points,
      this.created,
      this.updated});

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    description = json['description'];
    body = json['content'];
    category = json['category'];
    points = json['points'];
    created = DateTime.tryParse(json['created']);
    updated = DateTime.tryParse(json['updated']);
  }
}
