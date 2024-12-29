import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {
  String id;
  String name;
  String? email;
  String phone_number;
  Timestamp createdAt;
  // String updatedOn;

  Users({
    required this.id,
    required this.name,
    this.email,
    required this.phone_number,
    required this.createdAt,
    // required this.updatedOn,
  });

  factory Users.fromMap(Map<String, dynamic> data){
    return Users(id: data['id'], name:  data['name'], email: data['email'], phone_number: data['phone_number'], createdAt: data['createdAt']);
  }
}
