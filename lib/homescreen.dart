import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taskapp/addtask.dart';
import 'package:taskapp/localnotification.dart';
import 'package:taskapp/main.dart';
import 'package:taskapp/modal/taskmodal.dart';
import 'package:taskapp/taskcard.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

final user=FirebaseAuth.instance.currentUser;

signout()async{
await FirebaseAuth.instance.signOut();
}
final NotificationService notificationService = NotificationService();
void fetchTasksAndScheduleNotifications() async {
    final tasks = await FirebaseFirestore.instance.collection('tasks').get();
    print(tasks);
    for (var task in tasks.docs) {
    DateTime deadline = DateTime.parse(task['date']);
     print( deadline);
      DateTime notificationTime = deadline.subtract(Duration(minutes: 10));
print(notificationTime);
      // Schedule the notification
      notificationService.scheduleNotification(
        task.id.hashCode,
        'Task Reminder',
        'Your task "${task['title']}" is due soon!',
        notificationTime,
      );
    }
  }
// AuthClass authClass = AuthClass[];
final Stream<QuerySnapshot> _stream =
FirebaseFirestore.instance.collection("Task").snapshots();

  List<Taskmodal> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTasksAndScheduleNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252041) ,
      appBar: AppBar
      (
        leading: Icon(CupertinoIcons.home),
      title: 
       Text('TaskApp'),
      actions: [
    IconButton(onPressed: (){
      },
     icon: Icon( Icons.search)),

  
     IconButton(onPressed: (){
       Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) =>const Addtask() ,));
     }, icon: Icon(Icons.more_vert))
      ],
      ),
    
      body: StreamBuilder(
        stream: _stream,
        builder:(context, snapshot) {

        // 
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
            case ConnectionState.none:
            return const Center(child:CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:

             
         
            final data = snapshot.data?.docs;
         list = data?.map((e) => Taskmodal.fromJson(e.data() as Map<String, dynamic>)).toList() ?? [];
          
          if(list.isNotEmpty){

             
         
           
          return ListView.builder(
            itemCount: list.length,
            padding: EdgeInsets.only(top: mq.height *.02),
            itemBuilder:(context , index){
             return  TaskCard(
              name: list[index].title,date:list[index].date,description:list[index].description,id: data![index].id,);
            }
             );
       }else{
            return Center(child: Text('No Connections Found!',style: TextStyle(fontSize: 20),));
          }
        
          }
        
          
        },
      ),
    );
  }
  }
        
          
  
          
        
      
           
                    
          
        
      



      

      // floatingActionButton: FloatingActionButton(
      //   onPressed:(() => signout()),
      //   child: Icon(Icons.login_rounded),
      //   ),
   