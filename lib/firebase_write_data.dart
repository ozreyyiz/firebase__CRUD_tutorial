import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_crud_tutorial/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FirebaseWriteData extends StatefulWidget {
  FirebaseWriteData({Key? key}) : super(key: key);

  @override
  State<FirebaseWriteData> createState() => _FirebaseWriteDataState();
}

class _FirebaseWriteDataState extends State<FirebaseWriteData> {
  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerBirthday = TextEditingController();

  Future createUser({required User user}) async {
    final docUser = FirebaseFirestore.instance.collection("users").doc();
    user.id = docUser.id;
    final json = user.toJson();

    /// Create document and weite data to Firebase
    await docUser.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add User"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextField(
            controller: controllerName,
            decoration: decoration("Name"),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.number,
            controller: controllerAge,
            decoration: decoration("Age"),
          ),
          const SizedBox(height: 20),
          DateTimeField(
              controller: controllerBirthday,
              decoration: decoration("Birthday"),
              format: DateFormat("yyyy-mm-dd"),
              onShowPicker: (BuildContext context, DateTime? currentValue) {
                return showDatePicker(
                    context: context,
                    initialDate: currentValue ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100));
              }),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              final user = User(
                  name: controllerName.text,
                  age: int.parse(controllerAge.text),
                  birthday: DateTime.parse(controllerBirthday.text));
              controllerName.text = "";
              controllerAge.text = "";
              controllerBirthday.text = "";
              createUser(user: user);
            },
            child: Text("Create"),
          ),
        ],
      ),
    );
  }
}

InputDecoration decoration(String label) {
  return InputDecoration(
    labelText: label,
    border: OutlineInputBorder(),
  );
}
