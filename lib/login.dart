import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/forgot.dart';
import 'package:taskapp/signup.dart';
import 'package:taskapp/wrapper.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
TextEditingController email=TextEditingController();
TextEditingController password=TextEditingController();


signIn()async{
await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar
      (
       
      title:  Text('Login to TaskApp'),
     
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
            ElevatedButton(onPressed: (()=>signIn()), child: Text('Login')),
              SizedBox(height: 30,),
             ElevatedButton(onPressed: (()=>
              Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) =>const Signup() ,))),
              child: Text('Register Now')),
                 SizedBox(height: 30,),
              ElevatedButton(onPressed: (()=>
              Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) =>const Forgot() ,))),
              child: Text('Forgot Password ?'))
          ],
        ),
      ),
    );
  }
}