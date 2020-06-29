import 'package:audioholics/providers/user.dart';
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
  User author;

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
      @required this.author,
      this.created,
      this.updated});

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    description = json['description'];
    body = json['body'];
    category = json['category'];
    points = json['points'];
    author = new User.fromJson(json['author']);
    created = DateTime.tryParse(json['created']);
    updated = DateTime.tryParse(json['updated']);
  }
}
