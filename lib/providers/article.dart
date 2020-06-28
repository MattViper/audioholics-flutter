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
  Article.add(
      {@required this.title,
      @required this.description,
      @required this.category,
      @required this.body});

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

  Article.fromJson(Map<String, dynamic> _json) {
    id = _json['id'];
    slug = _json['slug'];
    title = _json['title'];
    description = _json['description'];
    body = _json['body'];
    category = _json['category'];
    points = _json['points'];
    created = DateTime.tryParse(_json['created']);
    updated = DateTime.tryParse(_json['updated']);
  }
}
