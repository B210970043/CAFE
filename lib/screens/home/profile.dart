import 'package:find_and_contact/src/models/user_model.dart';
import 'package:find_and_contact/src/provider/user_provider.dart';
import 'package:find_and_contact/widget/widget_support.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
  Users? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.green),
              child: Image.asset('images/man.png', 
                height: 150, 
                width: 150
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.facebook_rounded,size: 45,color: Colors.blue,),
                  Icon(Icons.email_rounded,size: 45,color: Colors.red,),
                  Icon(Icons.call_made_rounded,size: 45,color: const Color.fromARGB(255, 6, 78, 137),),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Center(
              child: Column(
                children: [
                  Text(
                    "${user?.name}",
                    style: AppWidget.nameOfUser(),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "${user?.email?? 'user@gmail.com'}"
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      'FIND EASILY AND CONTACT EASY!',
                      style: AppWidget.boldTextFieldStyleDefault(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: const Color.fromARGB(255, 201, 201, 201)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(Icons.privacy_tip_rounded, color: Colors.white,),
                              SizedBox(width: 10,),
                              Text(
                                'Privacy',
                                style: AppWidget.LightTextFieldStyle(),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_right_alt_outlined, color: Colors.black, size: 15,)
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: const Color.fromARGB(255, 201, 201, 201)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(Icons.privacy_tip_rounded, color: Colors.white,),
                              SizedBox(width: 10,),
                              Text(
                                'View history',
                                style: AppWidget.LightTextFieldStyle(),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_right_alt_outlined, color: Colors.black, size: 15,)
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),

                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: const Color.fromARGB(255, 201, 201, 201)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(Icons.privacy_tip_rounded, color: Colors.white,),
                              SizedBox(width: 10,),
                              Text(
                                'Help & support',
                                style: AppWidget.LightTextFieldStyle(),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_right_alt_outlined, color: Colors.black, size: 15,)
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),

                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: const Color.fromARGB(255, 201, 201, 201)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(Icons.privacy_tip_rounded, color: Colors.white,),
                              SizedBox(width: 10,),
                              Text(
                                'Settings',
                                style: AppWidget.LightTextFieldStyle(),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_right_alt_outlined, color: Colors.black, size: 15,)
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}