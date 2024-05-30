import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/login.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {

   TextEditingController email=TextEditingController();



reset()async{
await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar
      (
        leading: InkWell(
          onTap: () {
             Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) =>const Login() ,));
          },
          child: Icon(Icons.arrow_back_ios)),
      title:  Text('Reset Password for TaskApp'),
     
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: InputDecoration(hintText: 'Enter email'),
            ),

            SizedBox(height: 50,),
           
            ElevatedButton(onPressed: (()=>reset()), child: Text('Send link'))
          ],
        ),
      ),
    );
  }
}