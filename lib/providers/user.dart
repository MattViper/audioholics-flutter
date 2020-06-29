import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  int id;
  String artistName;
  String email;
  String role;
  String avatar;

  User(this.id, this.artistName, this.email, this.role, this.avatar);

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    artistName = json['artistName'];
    role = json['role'];
    avatar = json['avatar'];
  }
}
