import 'dart:convert';
import 'dart:io';

import 'package:audioholics/providers/article.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import './article.dart';
import '../config/constants.dart';

class Articles with ChangeNotifier {
  List<Article> _articles = [];
  Article _currentArticle;
  int _articlesCount = 0;

  String authToken;
  int userId;

  Articles();

  Article get currentArticle {
    return _currentArticle;
  }

  int get articlesCount {
    return _articlesCount;
  }

  List<Article> get articles {
    return [..._articles];
  }

  Articles update(authToken, userId, _articles) {
    this.authToken = authToken;
    this.userId = userId;
    this._articles = _articles;
    return this;
  }

  Future<void> findById(String slug) async {
    var url = Constants.API_URL + 'articles/$slug';
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ' + this.authToken,
          'Content-Type': 'application/json'
        },
      );
      final responseData = json.decode(response.body);
      final fetchedArticle = responseData['article'];

      Article article = new Article.fromJson(fetchedArticle);
      _currentArticle = article;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchArticles() async {
    _articles = new List<Article>();
    var url = Constants.API_URL + 'articles';
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ' + this.authToken,
          'Content-Type': 'application/json'
        },
      );
      final responseData = json.decode(response.body);
      final articlesCount = responseData['articlesCount'];

      var extractedData = responseData['articles'];

      //check if unathorized
      if (extractedData == null) {
        return;
      }
      final List<Article> loadedArticles = [];
      extractedData.forEach((articleData) {
        loadedArticles.add(Article.fromJson(articleData));
      });
      _articles = loadedArticles;
      _articlesCount = articlesCount;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addArticle(Article article) async {
    final url = Constants.API_URL + 'articles';
    var uri = Uri.parse(url);
    var headers = {
      'Authorization': 'Bearer ' + this.authToken,
      'Content-Type': 'application/json'
    };
    try {
      var request = http.MultipartRequest(
        'POST',
        uri,
      )
        ..fields['title'] = article.title
        ..fields['description'] = article.description
        ..fields['category'] = article.category
        ..fields['body'] = article.body
        ..files.add(await http.MultipartFile.fromPath(
            'headerImage', article.headerImage,
            contentType: MediaType('image', 'jpeg')))
        ..headers.addAll(headers);
      var response = await http.Response.fromStream(await request.send());
      final newArticle =
          Article.fromJson(json.decode(response.body)['article']);
      _articles.add(newArticle);
      // _Articles.insert(0, newArticle); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateArticle(int id, Article newArticle) async {
    final articleIndex = _articles.indexWhere((article) => article.id == id);
    if (articleIndex >= 0) {
      final url = Constants.API_URL + 'articles/$id';
      await http.put(url,
          headers: {
            'Authorization': 'Bearer ' + this.authToken,
            'Content-Type': 'application/json'
          },
          body: json.encode({
            'title': newArticle.title,
            'description': newArticle.description,
            'body': newArticle.body,
          }));
      _articles[articleIndex] = newArticle;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteArticle(int id) async {
    final url = Constants.API_URL + 'articles/$id';
    final existingArticleIndex =
        _articles.indexWhere((article) => article.id == id);
    var existingArticle = _articles[existingArticleIndex];
    _articles.removeAt(existingArticleIndex);
    notifyListeners();
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer ' + this.authToken,
        'Content-Type': 'application/json'
      },
    );
    if (response.statusCode >= 400) {
      _articles.insert(existingArticleIndex, existingArticle);
      notifyListeners();
      throw HttpException('Couldn\'t delete the article');
    }
    existingArticle = null;
  }

  Future<void> clap(String slug) async {
    final url = Constants.API_URL + 'articles/$slug';
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ' + this.authToken,
          'Content-Type': 'application/json'
        },
      );
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
