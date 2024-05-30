import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/login.dart';
import 'package:taskapp/wrapper.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  TextEditingController email=TextEditingController();
TextEditingController password=TextEditingController();


signup()async{
await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
 Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) =>const Wrapper() ,));
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar
      (
        leading:  InkWell(
          onTap: () {
             Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) =>const Login() ,));
          },
          child: Icon(Icons.arrow_back_ios)),
      title:  Text('SignUp to TaskApp'),
     
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: InputDecoration(hintText: 'Enter email'),
            ),
             TextField(
              controller: password,
              decoration: InputDecoration(hintText: 'Enter password'),
            ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (()=>signup()), child: Text('Signup'))
          ],
        ),
      ),
    );
  }
}