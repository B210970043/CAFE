import 'dart:io';

import 'package:find_and_contact/screens/home/detail.dart';
import 'package:find_and_contact/src/provider/car_provider.dart';
import 'package:find_and_contact/src/provider/starred_provider.dart';
import 'package:find_and_contact/src/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context).user;
    final starredCars = Provider.of<StarredProvider>(context).starredCars;
    final filteredCars = starredCars.where((filteredCars)=> filteredCars.userId == user!.phone_number).toList();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Title(
          color: Colors.black, child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Танд таалагдсан',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 90, 85, 85)
                ),
              ),
            ],
          )
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: filteredCars.length,
        itemBuilder: (context, index) {
          final car = filteredCars[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>CarDetail(zarId: "${car.carId}"))
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
                                '${car.name}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              IconButton(onPressed: (){}, 
                              icon: Icon(Icons.star),
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
          );
        },
      ),
    );
  }
}