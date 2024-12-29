import 'package:find_and_contact/src/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  Users? _user;
  Users? get user => _user;

  void setUser(Users user){
    _user = user;
    notifyListeners();
  }
}