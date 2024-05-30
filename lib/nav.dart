
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/addtask.dart';
import 'package:taskapp/homescreen.dart';

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
      
      
      
      child:  BottomNavigationBar(
        
        items:const [
         BottomNavigationBarItem( icon:  Icon(Icons.home,
            size: 40,
           ),
            label: 'Home',
          ),
          
         BottomNavigationBarItem( icon:  Icon(Icons.add,
            size: 40,
           ),
              label: 'Add'
          ),
         
         BottomNavigationBarItem( icon:  Icon(Icons.person,
            size: 40,
           ),
             label: 'Profile'
          ),
        ],
        
         
      
        backgroundColor:Color(0xff8a32f1),
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
   