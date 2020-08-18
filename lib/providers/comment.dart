import 'package:audioholics/providers/user.dart';
import 'package:flutter/foundation.dart';

class Comment with ChangeNotifier {
  int id;
  String body;
  DateTime created;
  DateTime updated;
  User author;

  Comment.add({
    @required this.body,
  });

  Comment(
      {this.id,
      @required this.body,
      @required this.author,
      this.created,
      this.updated});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    author = new User.fromJson(json['author']);
    created = DateTime.tryParse(json['created']);
    updated = DateTime.tryParse(json['updated']);
  }
}
