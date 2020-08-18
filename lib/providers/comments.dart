import 'dart:convert';

import 'package:audioholics/providers/comment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config/constants.dart';

class Comments with ChangeNotifier {
  List<Comment> _comments = [];

  String authToken;
  int userId;

  Comments();

  List<Comment> get comments {
    return [..._comments];
  }

  Comments update(authToken, userId, _comments) {
    this.authToken = authToken;
    this.userId = userId;
    this._comments = _comments;
    return this;
  }

  Future<void> fetchComments(String articleSlug) async {
    _comments = new List<Comment>();
    var url = Constants.API_URL + 'comments';
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ' + this.authToken,
          'Content-Type': 'application/json'
        },
      );
      final responseData = json.decode(response.body);

      if (responseData == null) {
        return;
      }
      final List<Comment> loadedComments = [];
      responseData.forEach((commentData) {
        loadedComments.add(Comment.fromJson(commentData));
      });
      _comments = loadedComments;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addComment(String articleSlug, String body) async {
    final url = Constants.API_URL + 'comments/$articleSlug';
    var uri = Uri.parse(url);
    var headers = {
      'Authorization': 'Bearer ' + this.authToken,
      'Content-Type': 'application/json'
    };
    try {
      var response = await http.post(uri,
          headers: headers,
          body: json.encode({
            'body': body,
          }));
      var xd = response.body;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
