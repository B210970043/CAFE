import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterService {
  final _auth = FirebaseAuth.instance;

  Future<bool> sentZarIntoSys(
    String zarId,
    String userPhoneNum,
    String orgOrHum,
    String name,
    String price,
    String type,
    String made_date,
    String arrivedDate,
    String leasing,
    String publishCondition,
    String mainImage,
    List<String> _image,
    ) async {
    try {
      await FirebaseFirestore.instance.collection('zars').doc().set({
        'zarId': zarId,
        'user': userPhoneNum,
        'name': name,
        'org_or_hum': orgOrHum,
        'price': price,
        'type': type,
        'made_date': made_date,
        'arrived_date': arrivedDate,
        'leasing': leasing,
        'publish_condition': publishCondition,
        'mainImage': mainImage,
        'ímages': _image,
        'createdAt': Timestamp.now(),
      });

      return true;
    } catch (e) {
      
      print("Error in sentZarIntoSys: $e");
      return false;    }
  }

}