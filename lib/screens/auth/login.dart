import 'dart:math';
import 'dart:ui';

import 'package:find_and_contact/screens/animation/text_utils.dart';
import 'package:find_and_contact/screens/auth/auth_service.dart';
import 'package:find_and_contact/screens/auth/signup.dart';
import 'package:find_and_contact/screens/home/home_page.dart';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
  
}

class _LoginState extends State<Login> {
  final _auth = AuthService();

  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    _email.dispose();
    _password.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromARGB(255, 56, 82, 103), //eneshuuc
      alignment: Alignment.center,
      child: Container(
        height: 400,
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
          
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                const Spacer(),
                Center(child: TextUtils(text: "ECAR",weight: true,size: 30,),),
                const Spacer(),
                TextUtils(text: "Имэйл хаяг"),
                Container(
                  height: 35,
                  decoration: const BoxDecoration(
                    border:  Border(bottom: BorderSide(color: Colors.white))
                  ),
                  child: TextFormField(
                    controller: _email,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.email, color: Colors.white,),
                    fillColor: Colors.white,
                    border: InputBorder.none
                    ),

                  ),
                ),
                const Spacer(),
                TextUtils(text: "Нууц үг"),
                Container(
                  height: 35,
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white)), 
                  ),
                  child: TextFormField(
                    controller: _password,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.lock, color: Colors.white,),
                      fillColor: Colors.black,
                      border: InputBorder.none
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Container(
                      height: 15,
                      width: 15,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10,),
                    Expanded(child: TextUtils(text: "Намайг сана", size: 12, weight: true,))

                  ],
                ),
                const Spacer(),
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: (){
                      _login();
                    }, 
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      overlayColor: Colors.green,
                    ),
                    child: Text(
                      'Нэвтрэх',
                      style: TextStyle(color: Colors.black)
                    ),
                    ),
                  ),
                
                const Spacer(),
                Center(
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Signup()));
                    },
                    child: Text('бүртгэлгүй бол энд дарна уу'),
                    
                  ),
                ),
                const Spacer(),
              ],
            ),          
          ),
        ),
      ),
      ),
    );
  }

  goToHome(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>const HomePage()),
  );

  _login() async{
    final user = await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);

    if(user != null){
      // log('User logged in' as num);
      goToHome(context);
    }
  }
}