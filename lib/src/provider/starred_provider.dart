import 'package:find_and_contact/src/models/starred_model.dart';
import 'package:flutter/material.dart';

class  StarredProvider with ChangeNotifier {
  List<StarredModel> _starredCars = [];

  List<StarredModel> get starredCars => _starredCars;

  void setStarredCar(List<StarredModel> starredCars) {
    _starredCars = starredCars;
    notifyListeners();
  }
}
