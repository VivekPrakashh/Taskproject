import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/edittask.dart';
import 'package:taskapp/main.dart';

class TaskCard extends StatefulWidget {
   TaskCard({super.key,required this.name,required this.date,required this.description,required this.id});
String?name;
String?date;
String?description;
String?id;
  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      
      margin: EdgeInsets.symmetric(horizontal: mq.width * .04, vertical: 4),
      elevation: 0.5,
      color: Colors.blue.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {},
        child: ListTile(
          leading: Checkbox(
            value: this.value,
            onChanged: (value) {
              setState(() {
                this.value = value!;
              });
            },
          ),

          title: Text('${widget.name}'),
          subtitle: Text('${widget.date}'),
          // trailing: Text('12 PM',style: TextStyle(color: Colors.black54),),
          trailing:  Column(
            children: [
               InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>
                  Edittask(date: widget.date!, title: widget.name!, description: widget.description!, id: widget.id!)));
                },
                 child: Icon(
                  Icons.edit,
                  color: Colors.blue,
                  size: 20,
                               ),
               ),
              SizedBox(height: 10,),
              InkWell(
                onTap: () {
                    FirebaseFirestore.instance.collection("Task").doc(widget.id).delete();
                },
                child: Icon(
                  Icons.delete,
                   size: 20,
                  color: Colors.red,
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
