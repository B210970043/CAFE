import 'package:cloud_firestore/cloud_firestore.dart';

class StarredService {
  Future<bool> saveIntoStarredZar(
    String carId,
    String name,
    String mainImage,
    String userId,
    ) async {
    try {
      await FirebaseFirestore.instance.collection('fav_zars').doc().set({
        'carId': carId,
        'name': name,
        'mainImage': mainImage,
        'userId': userId,
      });

      return true;
    } catch (e) {
      
      print("Error in saveIntoStarredZar: $e");
      return false;    }
  }
}