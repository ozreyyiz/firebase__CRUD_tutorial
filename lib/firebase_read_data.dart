import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_tutorial/firebase_update_data.dart';
import 'package:firebase_crud_tutorial/firebase_write_data.dart';
import 'package:firebase_crud_tutorial/user_model.dart';
import 'package:flutter/material.dart';

class FirebaseReadData extends StatefulWidget {
  FirebaseReadData({Key? key}) : super(key: key);

  @override
  State<FirebaseReadData> createState() => _FirebaseReadDataState();
}

class _FirebaseReadDataState extends State<FirebaseReadData> {
  Stream<List<User>> readUsers() {
    return FirebaseFirestore.instance.collection("users").snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Read Data"),
      ),
      body: StreamBuilder<List<User>>(
        stream: readUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                User user = users[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FirebaseUpdateData(
                                  user: user,
                                )));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text("${user.age}"),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.birthday.toIso8601String()),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("Something went wrong! ${snapshot.error}");
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FirebaseWriteData()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildUser(User user) => ListTile(
        leading: CircleAvatar(
          child: Text("${user.age}"),
        ),
        title: Text(user.name),
        subtitle: Text(user.birthday.toIso8601String()),
      );
}
