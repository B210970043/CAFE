import 'package:cloud_firestore/cloud_firestore.dart';

class Cars {
  String? zarId;
  String? user;
  String? name;
  String? price;
  String? type;
  Timestamp? createdAt;
  String? arrived_date;
  String? leasing;
  String? made_date;
  String? org_or_hum;
  String? publish_condition;
  List<String> images;
  String? mainImage;


  Cars({
    this.zarId,
    this.user,
    this.name,
    this.price,
    this.type,
    this.createdAt,
    this.arrived_date,
    this.leasing,
    this.made_date,
    this.org_or_hum,
    this.publish_condition,
    required this.images,
    this.mainImage,
  });

  factory Cars.fromMap(Map<String, dynamic> data){
    return Cars(
      zarId: data['zarId'],
      user: data['user'],
      name: data['name'], 
      price: data['price'], 
      type: data['type'], 
      createdAt: data['createdAt'], 
      arrived_date: data['arrived_date'], 
      leasing: data['leasing'], 
      made_date: data['made_date'], 
      org_or_hum: data['org_or_hum'], 
      publish_condition: data['publish_condition'], 
      mainImage: data['mainImage'],
      images: List<String>.from(data['images'] ?? []));
  }
}
