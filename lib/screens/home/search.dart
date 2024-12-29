import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_and_contact/screens/home/detail.dart';
import 'package:find_and_contact/screens/home/profile.dart';
import 'package:find_and_contact/src/models/car_model.dart';
import 'package:find_and_contact/src/models/starred_model.dart';
import 'package:find_and_contact/src/models/user_model.dart';
import 'package:find_and_contact/src/provider/car_provider.dart';
import 'package:find_and_contact/src/provider/starred_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:find_and_contact/widget/widget_support.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../src/provider/user_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}
enum SampleItem { itemOne, itemTwo, itemThree }

class _SearchPageState extends State<SearchPage> {
  List<Cars> ?cars;
  String ?name;
  @override
  void initState() {
    super.initState();

    var userId = FirebaseAuth.instance.currentUser?.uid;
    
    if (userId != null) {
      fetchUserData(userId).then((data) {
        if (data != null) {
          final userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.setUser(data);
        } else {
          print('User data not found');
        }
      });
    }

    fetchCarData().then((data) {
      if (data != null && data.isNotEmpty) {
        final carProvider = Provider.of<CarProvider>(context, listen: false);
        carProvider.setCar(data);
        print("Car Data: ${data.length} cars fetched");
      } else {
        print('No car data found');
      }
    });

    fetchStarredCarData().then((data) {
      if (data != null && data.isNotEmpty) {
        final carStarredProvider = Provider.of<StarredProvider>(context, listen: false);
        carStarredProvider.setStarredCar(data);
        print("Car Data: ${data.length} cars fetched");
      } else {
        print('No car data found');
      }
    });
  }
  Future<Users?> fetchUserData(String userId) async {
      try{
        final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

        if(userDoc.exists && userDoc.data() != null){
          Map<String, dynamic> data = userDoc.data()!;
          return Users.fromMap(userDoc.data()!);
        }
      }catch(e){
        print(e);
      }
    }

  Future<List<Cars>?> fetchCarData() async {
    try {
      final carCollection = await FirebaseFirestore.instance.collection('zars').get();
      if (carCollection.docs.isNotEmpty) {
        List<Cars> carList = carCollection.docs
            .map((doc) => Cars.fromMap(doc.data()))
            .toList();
        return carList;
      } else {
        print('байдгүйээээ хө');
        return null;
      }
    } catch (e) {
        print('Error fetching car data: $e');
        return null;
      }
    }

    Future<List<StarredModel>?> fetchStarredCarData() async {
    try {
      final starredCars = await FirebaseFirestore.instance.collection('fav_zars').get();
      if (starredCars.docs.isNotEmpty) {
        List<StarredModel> starredList = starredCars.docs
            .map((doc) => StarredModel.fromMap(doc.data()))
            .toList();
        return starredList;
      } else {
          print('байдгүйээээ хө');
        return null;
      }
    } catch (e) {
        print('Error fetching car data: $e');
        return null;
      }
    }

  File imageFile = File("/data/user/0/com.example.find_and_contact/cache/scaled_1000000.png");


  int selectedIndex = 0;
  List<String> carLogoImages = [
    "images/cars/logo.jpg",
    "images/honda.png",
    "images/hyundai.png",
    "images/subaru.png",
    "images/toyota.png",
  ];
  SampleItem? selectedItem;
  @override
  Widget build(BuildContext context) {
    cars = Provider.of<CarProvider>(context).cars;
    return Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Types of Car",
                            style: AppWidget.HeadlineTextFieldStyle(),
                          ),
                          PopupMenuButton(
                            color: Colors.white,
                            initialValue: selectedItem,
                            onSelected: (SampleItem item){
                              setState(() {
                                selectedItem = item;
                              });
                            },
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                              PopupMenuItem<SampleItem>(
                                value: SampleItem.itemOne,
                                child: TextButton(
                                  onPressed:() {
                                    Navigator.push(
                                      context, 
                                      MaterialPageRoute(builder: (context)=> ProfilePage())
                                    );
                                  },
                                  child: Text('Хувийн мэдээлэл', style: TextStyle(color: Colors.black),)
                                )
                              ),
                              PopupMenuItem<SampleItem>(
                                value: SampleItem.itemTwo,
                                child: TextButton(
                                  onPressed:() {
                                    Navigator.push(
                                      context, 
                                      MaterialPageRoute(builder: (context)=> ProfilePage())
                                    );
                                  },
                                  child: Text('Миний зар', style: TextStyle(color: Colors.black),)
                                )
                              ),
                            ]
                          )
                        ]
                      ),
                      Text(
                        "choose the car type",
                        style: AppWidget.LightTextFieldStyle(),
                      ),
                      SizedBox(height: 20.0,),
                  
                      showTypes(),
                      SizedBox(height: 30.0,),
                      showCarsRecently(),
                      SizedBox(height: 10,),
                      hasLeasing(),
                      SizedBox(height: 20,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Шинээр нэмэгдсэн',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      RecentlyAdded(),
                      
                    ],
                  ),
                ),
              ]
          ),
        ));
  }

  Widget showTypes(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: 
          List.generate(carLogoImages.length, (index){
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedIndex == index ? Colors.grey : Colors.white,
                  ),
                  padding: EdgeInsets.all(8),
                  child: Padding(padding: EdgeInsets.symmetric(horizontal: 12),child: Image.asset(carLogoImages[index], height: 50 ),)
                ),
              ),
            );
          })
      )
    );
    }

  Widget showCarsRecently() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Топууд',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        Row(        
            children: cars!.map((car) {
              return Container(
              margin: EdgeInsets.all(4),
              child: car.publish_condition == "VIP" ?
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>CarDetail(zarId: "${car.zarId}"))
                    );
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // For image, you can use an image URL if it's from Firestore
                          // Image.asset(
                          //   car.imageUrl, // Assuming car has imageUrl field
                          //   height: 150,
                          //   width: 150,
                          //   fit: BoxFit.cover,
                          // ),
                          
                          Stack(
                            children: [
                              car.mainImage!=null
                                ? Image.file(
                                    File("${car.mainImage}"),
                                    
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.fill,
                                    alignment: Alignment.center,
                                  )
                                : Image.asset(
                                    "images/cars/1.jpg",
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.fill,
                                    alignment: Alignment.center,
                                  ),
                              Positioned(
                                top: 10,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  child: Text(
                                    'VIP',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                    ),
                                  ),
                                )
                              )
                            ],
                          ),
                          
                          SizedBox(height: 10),
                          Text(
                            "${car.name}",
                            style: AppWidget.nameOFTextFieldStyle(),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Нийтэлсэн: ${car.made_date}',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '₮${car.price} сая',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ):SizedBox()
              );
          }).toList(),
          ),
      ],
    ),
    );
  }

  Widget hasLeasing() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Лизингээр авах',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          Row(        
              children: cars!.map((car) {
                return Container(
                margin: EdgeInsets.all(4),
                child: car.leasing == "байгаа" ?
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>CarDetail(zarId: "${car.zarId}"))
                      );
                    },
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // For image, you can use an image URL if it's from Firestore
                            // Image.asset(
                            //   car.imageUrl, // Assuming car has imageUrl field
                            //   height: 150,
                            //   width: 150,
                            //   fit: BoxFit.cover,
                            // ),
                            
                            Stack(
                              children: [
                                car.mainImage!=null
                                  ? Image.file(
                                      File("${car.mainImage}"),
                                      
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.fill,
                                      alignment: Alignment.center,
                                    )
                                  : Image.asset(
                                      "images/cars/1.jpg",
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.fill,
                                      alignment: Alignment.center,
                                    ),
                                Positioned(
                                  top: 10,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    child: car.publish_condition == 'VIP'? Text(
                                      'VIP',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                      ),
                                    ):Text(''),
                                  )
                                )
                              ],
                            ),
                            
                            SizedBox(height: 10),
                            Text(
                              "${car.name}",
                              style: AppWidget.nameOFTextFieldStyle(),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Нийтэлсэн: ',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '₮${car.price} сая',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ):SizedBox()
                );
            }).toList(),
            ),
        ],
      ),
    );
  }

  Widget RecentlyAdded(){
    return SizedBox(
      height: MediaQuery.of(context).size.height/2,
      child: SingleChildScrollView(
        child: Column(
          children: cars!.map((car) {
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> CarDetail(zarId: "${car.zarId}")));
              },
              child: Material(
                elevation: 5.0,
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          car.mainImage != null? 
                          Image.file(
                          File("${car.mainImage}"), 
                          height: 90, 
                          width: 90, 
                          fit: BoxFit.cover,):Image.asset('images/cars/1.jpg'),
                      
                          car.publish_condition == 'VIP' ? 
                            Positioned(
                              child: Container(
                                padding: EdgeInsets.all(3),
                                child: Text(
                                  'VIP', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 10),
                                ),
                              )
                            ) : SizedBox(),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                
                          children: [
                             Text(
                              "${car.name}",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              'Таны замыг дөтлөх хүлэг ирлээ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 15,),
                            Text(
                              'Нийтэлсэн'+ '2024.12.12',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],   
                  ),
                ),
              ),
            );            
          }).toList(),
        ),
      ),
    );
  }
}