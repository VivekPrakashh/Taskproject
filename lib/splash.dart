import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/homescreen.dart';
import 'package:taskapp/login.dart';
import 'package:taskapp/main.dart';
import 'package:taskapp/wrapper.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override

  void initState() {
   
    super.initState();
    Future.delayed(const Duration(seconds: 2),(){
     
         Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) =>const Wrapper() ,));
  
    
    }
    );

  }
  Widget build(BuildContext context) {
     mq =MediaQuery.of(context).size;
    return Scaffold(
       body: Stack(children: [
         Positioned(
          top: mq.height *.15,
          width: mq.width *.5,
          right: mq.width *.25,
          child: Image.asset('images/meetme.png')),

           Positioned(
          bottom: mq.height *.15,
          width: mq.width,
        
         
          child: Text('Made in Bharat ❤️',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color:  Colors.black),)
          )
          
      ],),
    );
  }
}