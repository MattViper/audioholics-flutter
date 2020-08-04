import 'dart:convert';

import 'package:audioholics/config/constants.dart';
import 'package:audioholics/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profiles with ChangeNotifier {
  User _profile;
  String authToken;
  int userId;

  User get profile {
    return _profile;
  }

  Profiles update(authToken, userId, _profile) {
    this.authToken = authToken;
    this.userId = userId;
    this._profile = _profile;
    return this;
  }

  Future<void> findByEmail(String email) async {
    var url = Constants.API_URL + 'profile/$email';
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ' + this.authToken,
          'Content-Type': 'application/json'
        },
      );
      final responseData = json.decode(response.body);
      _profile = responseData;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
