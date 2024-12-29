import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(String id, String email, String password, String username, String phone_number) 
  async{
    try{
      final cred =  await _auth.createUserWithEmailAndPassword(email: email, password: password);

      String uid = cred.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'id': id,
        'phone_number': phone_number,
        'name': username, 
        'createdAt': FieldValue.serverTimestamp(),
      });

      return cred.user;
    }catch(e){
      // log("Something went wrong" as num);
      
    }
    return null;
  }
    Future<User?> loginUserWithEmailAndPassword(String email, String password) 
    async{
      try{
        final cred =  await _auth.signInWithEmailAndPassword(email: email, password: password);
        return cred.user;
      }catch(e){
        log("Something went wrong" as num);
      }
      return null;
    }
    Future<void> signOut() async{
      try{
        await _auth.signOut();
      }catch(e){
        log("Something went wrong" as num);
      }
    }
    Future<void> createNew(String type, String car_name, double price, String status, DateTime when_come, String location, DateTime published, int num_of_door, String hutlugch_type) async{
      try{
        final car_reg = await createNew(type, car_name, price, status, when_come, location, published, num_of_door, hutlugch_type);
        return car_reg;
      }catch(e){}
    }
}