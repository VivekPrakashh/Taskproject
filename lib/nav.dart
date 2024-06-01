import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskapp/addtask.dart';
import 'package:taskapp/dialogs.dart';
import 'package:taskapp/homescreen.dart';
import 'package:taskapp/login.dart';
import 'package:taskapp/main.dart';
import 'package:taskapp/signup.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int activeindex = 0;
  int currentindex = 0;
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Homescreen(),
    Addtask(),
    Dummy()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: ClipRRect(
        clipBehavior: Clip.none,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 40,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add,
                  size: 40,
                ),
                label: 'Add'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.logout,
                  size: 40,
                ),
                label: 'Logout'),
          ],
          backgroundColor: Color(0xff8a32f1),
          selectedLabelStyle:
              TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade400,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
   signout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Dialogs.showSnackbar(context, ' Logout Sucessfully');
    } catch (e) {
      print("error =>$e");
      Dialogs.showSnackbar(context, 'Something went wrong');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: mq.height,
        width: mq.width,
        color: Color(0xff252041),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('images/icon.png.png')),
              SizedBox(height: 30,),
             Text("Thankyou for using TaskApp",style:
               TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
               SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.remove('userID');
                      myUserId = "";
                       signout();
                      Navigator.push(
                          context, MaterialPageRoute(builder: (builder) => Login()));
                    },
                    child: Text("Logout",style:
                     TextStyle(fontSize: 18,color: Color.fromARGB(255, 160, 85, 245),fontWeight: FontWeight.bold),)),
                     SizedBox(width: 10,),
                      Icon(Icons.logout,color: Color.fromARGB(255, 160, 85, 245),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
