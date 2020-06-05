import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  int id;
  String artistName;
  String email;
  String role;
  String avatar;

  User(this.id, this.artistName, this.email, this.role, this.avatar);

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    artistName = json['artistName'];
    email = json['email'];
    role = json['role'];
    avatar = json['avatar'];
  }
}
