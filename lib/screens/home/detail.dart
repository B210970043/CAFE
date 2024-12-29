import 'dart:io';

import 'package:find_and_contact/screens/auth/starred_service.dart';
import 'package:find_and_contact/src/models/car_model.dart';
import 'package:find_and_contact/src/models/user_model.dart';
import 'package:find_and_contact/src/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../src/provider/car_provider.dart';

class CarDetail extends StatelessWidget {
  final String zarId;
  StarredService service = new StarredService();
  CarDetail({super.key, required this.zarId});
  @override
  Widget build(BuildContext context) {
    final cars = Provider.of<CarProvider>(context).cars;
    final user = Provider.of<UserProvider>(context).user;
    final car = cars.firstWhere((car)=> car.zarId == zarId,);
  
    bool isSaved = false;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            width: 500,
            child: Stack(
              children: [
                Image.file(
                File("${car.mainImage}"),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              Positioned(
                child: Container(
                  decoration: BoxDecoration(
                  ),
                  child: IconButton.filled(
                    onPressed: (){
                      isSaved = true;
                      saveZar("${car.zarId}","${car.name}","${car.mainImage}", "${user?.phone_number}");
                      print(car.zarId);
                    },
                    icon: Icon(Icons.star,color: isSaved==false? Colors.white: Colors.yellow,),
                    ),
                )
              )],
            )
          ),
          Container(
            decoration: BoxDecoration(color: Colors.red,),
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₮${car.price} сая',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),
                    Text(
                      '${car.name} автомашин',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${car.user} утасны дугаар' ,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 12,
                        fontStyle: FontStyle.italic
                      ),
                    ),
                    Text(
                      'нийтэлсэн: ${car.made_date}',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 15
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.symmetric(horizontal: BorderSide(color: Colors.blueGrey, width: 2)),
                    ),
                    margin: EdgeInsets.all(7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Leasing :',
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          '${car.leasing}',
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                    
                  Container(
                    decoration: BoxDecoration(
                      border: Border.symmetric(horizontal: BorderSide(color: Colors.blueGrey, width: 2)),
                    ),
                    margin: EdgeInsets.all(7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Үйлдвэрлэгдсэн он :',
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          '${car.made_date}',
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.symmetric(horizontal: BorderSide(color: Colors.blueGrey, width: 2)),
                    ),
                    margin: EdgeInsets.all(7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Орж ирсэн он :',
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          '${car.arrived_date}',
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.symmetric(horizontal: BorderSide(color: Colors.blueGrey, width: 2)),
                    ),
                    margin: EdgeInsets.all(7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Төрөл :',
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          '${car.type}',
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 5,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.symmetric(horizontal: BorderSide(color: Colors.blueGrey, width: 2)),
                    ),
                    margin: EdgeInsets.all(7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Утасны дугаар :',
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          '55515907',
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.symmetric(horizontal: BorderSide(color: Colors.blueGrey, width: 2)),
                    ),
                    margin: EdgeInsets.all(7),
                    child: Column(
                      children: [
                        Text(
                          'Дэлгэрэнгүй',
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          'Эмэгтэй хүний гараар 3 жил унасан сэв зураасгүй маш цэвэрхэн машин',
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  void saveZar(String carId,String name, String mainImage, String userId) async{
    print(userId);
    if(carId != "" && userId != ""){
      bool isSent =  await service.saveIntoStarredZar(carId, name, mainImage, userId);
      print(isSent);
    }
  }
}