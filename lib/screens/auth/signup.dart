import 'dart:collection';
import 'dart:math';
import 'dart:ui';

import 'package:find_and_contact/screens/animation/text_utils.dart';
import 'package:find_and_contact/screens/auth/auth_service.dart';
import 'package:find_and_contact/screens/auth/login.dart';
import 'package:find_and_contact/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final _auth = AuthService();
  final _name = TextEditingController();
  final _password = TextEditingController();
  final _email = TextEditingController();
  final _phone_number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios),
      ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromARGB(255, 56, 82, 103),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 600,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(15),
              color: Colors.black.withOpacity(0.1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Center(child: TextUtils(text: "ECAR БҮРТГЭЛ", weight: true,size: 30,),),
                      const Spacer(),
                            
                      TextUtils(text: "Нэр"),
                      const Spacer(),
                      Container(
                        height: 35,
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.white))
                        ),
                        child: TextFormField(
                          controller: _name,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.man, color: Colors.white,),
                            fillColor: Colors.white,
                            border: InputBorder.none
                          ),
                        ),
                      ),
                            
                      TextUtils(text: "Имэйл хаяг"),
                      const Spacer(),                  
                      Container(
                        height: 35,
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.white))
                        ),
                        child: TextFormField(
                          controller: _email,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.phone, color: Colors.white,),
                            fillColor: Colors.white,
                            border: InputBorder.none
                          ),
                        ),
                      ),
                            
                      TextUtils(text: "Нууц үг"),
                      const Spacer(),
                      Container(
                        height: 35,
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.white))
                        ),
                        child: TextFormField(
                          controller: _password,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.password, color: Colors.white,),
                            fillColor: Colors.white,
                            border: InputBorder.none
                          ),
                        ),
                      ),
                            
                      TextUtils(text: "Утасны дугаар"),
                      const Spacer(),
                      Container(
                        height: 35,
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.white))
                        ),
                        child: TextFormField(
                          controller: _phone_number,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.phone_android_outlined, color: Colors.white,),
                            fillColor: Colors.white,
                            border: InputBorder.none
                          ),
                        ),
                      ),
                      
                      const Spacer(),
                      Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: (){
                            signUp();
                          }, 
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            overlayColor: Colors.green,
                          ),
                          child: Text(
                            'Бүртгэл үүсгэх',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              
                            ),
                          )
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  goToLogin(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>const Login()),
  );
  goToHome(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>const HomePage()),
  );
  
  signUp() async{
    String userId  = Uuid().v4();

    final user =  await _auth.createUserWithEmailAndPassword(userId,_email.text, _password.text, _name.text, _phone_number.text);
    
    if(user!= null){
      goToLogin(context);
    }else{
    }
  }
}