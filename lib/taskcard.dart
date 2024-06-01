import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/dialogs.dart';
import 'package:taskapp/edittask.dart';
import 'package:taskapp/main.dart';
import 'package:taskapp/signup.dart';

class TaskCard extends StatefulWidget {
  TaskCard(
      {super.key,
      required this.name,
      required this.date,
      required this.description,
      required this.status,
      required this.id});
  String? name;
  String? date;
  String? description;
  int? status;
  String? id;
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
            value: widget.status == 0 ? false : true,
            onChanged: (value) {
              if (widget.status == 0) {
                FirebaseFirestore.instance
                    .collection('Users')
                    .doc(myUserId)
                    .collection('Tasks')
                    .doc(widget.id)
                    .update(
                  {"status": 1},
                );
              } else {
                FirebaseFirestore.instance
                    .collection('Users')
                    .doc(myUserId)
                    .collection('Tasks')
                    .doc(widget.id)
                    .update(
                  {"status": 0},
                );
              }
              setState(() {
                this.value = value!;
              });
            },
          ),
       

          title: Text('${widget.name}'),
          subtitle: Text('${widget.date!.substring(0, 16)}'),
          // trailing: Text('12 PM',style: TextStyle(color: Colors.black54),),
          trailing: SizedBox(
            width: 50,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => Edittask(
                                date: widget.date!,
                                title: widget.name!,
                                description: widget.description!,
                                id: widget.id!)));
                  },
                  child: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                    size: 20,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () async {
                   
                    try{
                      
                    await FirebaseFirestore.instance
                        .collection('Users')
                        .doc(myUserId)
                        .collection('Tasks')
                        .doc(widget.id)
                        .delete();
                         Dialogs.showSnackbar(context, 'Task Deleted Sucessfully');
                    
                    }catch (e) {
                          print("error =>$e");
                           Dialogs.showSnackbar(context,'Something went wrong');
                    }
                  },
                  child: const Icon(
                    Icons.delete,
                    size: 20,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
