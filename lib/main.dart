import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/forgot.dart';
import 'package:taskapp/login.dart';
import 'package:taskapp/signup.dart';
import 'package:taskapp/splash.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


late Size mq;
void main()async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskApp',
      theme: ThemeData(
       appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
        
         backgroundColor: Color(0xff8a32f1) ,
          
       )
      
      ),
      debugShowCheckedModeBanner: false,
       home: Splash(),
        routes: {
        
            '/spalsh': (context) => const Splash(),
             '/login': (context) => const Login(),
              '/sigup': (context) => const Signup(),
               '/forgot': (context) => const Forgot(),
            
          
            //  '/profile': (context) => const Profile(),
   }
    );
  }
}

