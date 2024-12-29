import 'package:cloud_firestore/cloud_firestore.dart';


class StarredModel {
  String? carId;
  String? name;
  String? mainImage;
  String? userId;

  StarredModel({
    this.carId,
    this.name,
    this.mainImage,
    this.userId,
  });

  factory StarredModel.fromMap(Map<String, dynamic> data){
    return StarredModel(
      carId: data['carId'],
      name: data['name'],
      mainImage: data['mainImage'],
      userId: data['userId']
    );
  }
}
