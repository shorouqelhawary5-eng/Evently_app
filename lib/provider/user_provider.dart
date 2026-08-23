import 'package:evently_app/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String name = '';
  String email = '';

  void updateUserData(UserModel userData) {
    name = userData.name;
    email = userData.email;
    notifyListeners();
  }
}
