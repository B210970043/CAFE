import 'package:find_and_contact/src/models/car_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CarProvider with ChangeNotifier {
  List<Cars> _cars = [];

  List<Cars> get cars => _cars;

  void setCar(List<Cars> cars) {
    _cars = cars;
    notifyListeners();
  }

  // Cars getCarByIndex(int index) {
  //   return _cars[index];
  // }
}
