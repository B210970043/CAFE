import 'dart:io';

import 'package:find_and_contact/screens/home/detail.dart';
import 'package:find_and_contact/src/provider/car_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cars = Provider.of<CarProvider>(context).cars;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey,
        title: Title(
          color: Colors.black, child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Шинэ мэдэгдэл',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ],
          )
        ),
      ),
      
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return car.publish_condition == "VIP" ? GestureDetector(
            onTap: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context)=>CarDetail(zarId: "${car.zarId}"))
              );
            },
            child: Material(
            elevation: 7,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.file(
                        File("${car.mainImage}"), 
                        height: 90,
                        width: 90, 
                        fit: BoxFit.fill,
                      ),
                      car.publish_condition == "VIP"?
                        Positioned(
                          child: Text(
                            'VIP', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 10),
                          )
                        ):SizedBox(),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Эзнээ хүлээж байгаа цоо шинэ тэрэг та бүхэн яараарай'
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '₮${car.price} сая',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              IconButton(onPressed: (){}, 
                              icon: Icon(Icons.notification_important_rounded),
                              color: Colors.orange,
                            ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
                    ),
          ):SizedBox();
        },
      ),
    );
  }
}