import 'dart:async';
import 'dart:convert';

import 'package:audioholics/helpers/jwt_decoder.dart';
import 'package:audioholics/models/secure_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/constants.dart';
import '../models/http_exception.dart';

class Auth with ChangeNotifier, SecureStorageMixin {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String _token;
  DateTime _expiryDate;
  int _userId;
  Timer _authTimer;

  bool _artistNameExists;
  bool _emailExists;

  String _role;
  String _email;
  String _artistName;
  String _avatar;

  String get email {
    return _email;
  }

  String get artistName {
    return _artistName;
  }

  String get avatar {
    return _avatar;
  }

  Map<String, dynamic> _decodedToken;

  bool get isAuth {
    return token != null;
  }

  set isAuth(bool state) {
    isAuth = state;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  int get userId {
    return _userId;
  }

  String get role {
    return _role;
  }

  bool get artistNameExists {
    return _artistNameExists;
  }

  bool get emailExists {
    return _emailExists;
  }

  Future<void> login(String email, String password) async {
    final url = Constants.API_URL + "auth/signin";
    final SharedPreferences prefs = await _prefs;
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'email': email,
            'password': password,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['token'];
      _userId = responseData['id'];
      _role = responseData['role'];
      _decodedToken = JwtDecoder.tryParseJwt(_token);
      _email = responseData['email'];
      _artistName = responseData['artistName'];
      _avatar = responseData['avatar'];
      var values = _decodedToken.values.toList();
      var expiresIn = values[2] - values[1];

      _expiryDate = DateTime.now().add(
        Duration(
          seconds: expiresIn,
        ),
      );

      _autoLogout();

      prefs.setString('token', _token);
      prefs.setString('expiryDate', _expiryDate.toIso8601String());
      prefs.setString('avatar', _avatar);
      prefs.setString('role', _role);
      prefs.setString('email', _email);
      prefs.setString('artistName', _artistName);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password, String artistName) async {
    final url = Constants.API_URL + 'auth/signup';
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'email': email,
            'password': password,
            'artistName': artistName,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final SharedPreferences prefs = await _prefs;
    final token = prefs.getString('token');
    if (token == null) {
      return false;
    }

    final expiryDate = DateTime.parse(prefs.getString('expiryDate'));

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = token;
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await _prefs;
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    prefs.clear();
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future<void> checkArtistName(String artistName) async {
    final url = Constants.API_URL + "auth/checkartistname";
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(
            {
              'artistName': artistName,
            },
          ));

      bool artistNameExists = json.decode(response.body);
      _artistNameExists = artistNameExists;

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> checkEmail(String email) async {
    final url = Constants.API_URL + "auth/checkemail";
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(
            {
              'email': email,
            },
          ));

      bool emailExists = json.decode(response.body);
      _emailExists = emailExists;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
