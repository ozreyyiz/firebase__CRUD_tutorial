import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_tutorial/firebase_read_data.dart';
import 'package:firebase_crud_tutorial/user_model.dart';
import 'package:flutter/material.dart';

class FirebaseUpdateData extends StatefulWidget {
  FirebaseUpdateData({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<FirebaseUpdateData> createState() => _FirebaseUpdateDataState();
}

class _FirebaseUpdateDataState extends State<FirebaseUpdateData> {
  final controllerName = TextEditingController();
  @override
  void initState() {
    super.initState();
    controllerName.text = widget.user.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Update Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: controllerName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final docUser = FirebaseFirestore.instance
                          .collection("users")
                          .doc(widget.user.id);

                      docUser.update({"name": "${controllerName.text}"});
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FirebaseReadData()));
                    },
                    child: Text("Update"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {
                      final docUser = FirebaseFirestore.instance
                          .collection("users")
                          .doc(widget.user.id);

                      docUser.delete();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FirebaseReadData()));
                    },
                    child: Text("Delete"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
