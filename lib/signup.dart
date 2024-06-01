import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskapp/dialogs.dart';
import 'package:taskapp/login.dart';
import 'package:taskapp/main.dart';
import 'package:taskapp/wrapper.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> _signUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('Users').doc(user.uid).set({
          'email': user.email,
          'createdAt': FieldValue.serverTimestamp(),
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userID', user.uid);
        myUserId = user.uid;
        print("MyuserId : $myUserId");
        Dialogs.showSnackbar(context, 'Signup Sucessfully');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Wrapper(),
            ));
      }
    } catch (e) {
      print("error =>$e");
      Dialogs.showSnackbar(context, 'Something went wrong');
    }
  }

  // signup() async {
  //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email.text, password: password.text);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff252041),
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ));
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: const Text('Signup to TaskApp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: email,
              decoration: const InputDecoration(
                  hintText: 'Enter email',
                  hintStyle: TextStyle(color: Colors.white)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: password,
              decoration: const InputDecoration(
                  hintText: 'Enter password',
                  hintStyle: TextStyle(color: Colors.white)),
            ),
            const SizedBox(
              height: 50,
            ),

            // Signup button
            InkWell(
              onTap: () {
                _signUp();
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
                      'Signup',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

String myUserId = "";
