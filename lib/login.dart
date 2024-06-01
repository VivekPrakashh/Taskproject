import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskapp/dialogs.dart';
import 'package:taskapp/forgot.dart';
import 'package:taskapp/main.dart';
import 'package:taskapp/nav.dart';
import 'package:taskapp/signup.dart';
import 'package:taskapp/wrapper.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signIn() async {
    try{
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: password.text);

    User? user = userCredential.user;
    myUserId = user!.uid;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userID', user.uid);
      Dialogs.showSnackbar(context, 'Login Sucessfully');
    Navigator.push(context, MaterialPageRoute(builder: (builder) => Nav()));
  }
  catch (e) {
                          print("error =>$e");
                           Dialogs.showSnackbar(context,'Wrong Email or Password');
  }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252041),
      appBar: AppBar(
        title: Text('Login to TaskApp'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: email,
                decoration: const InputDecoration(
                    hintText: 'Enter email',
                    hintStyle: TextStyle(color: Colors.white)),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: password,
                decoration: const InputDecoration(
                    hintText: 'Enter password',
                    hintStyle: TextStyle(color: Colors.white)),
              ),
              const SizedBox(
                height: 50,
              ),
        
        // login button
              InkWell(
                onTap: () {
                  signIn();
                },
                child: Container(
                    height: 40,
                    width: mq.width,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xff8a32f1), Color(0xffad32f9)]),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                    onPressed: (() => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Forgot(),
                        ))),
                    child: const Text(
                      'Forgot Password ?',
                      style: TextStyle(color: Color(0xffad32f9)),
                    )),
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'If you are new here!',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
        
                  // signup page navigation
        
                  InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Signup(),
                            ));
                      },
                      child: const Text(
                        'Register Now',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffad32f9)),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
