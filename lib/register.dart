import 'dart:io';

import 'package:demo/login.dart';
import 'package:demo/model/Hobbies.dart';
import 'package:demo/model/user.dart';
import 'package:demo/util/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  File _imageFile;
  String email, userName, password, dob;
  DateTime selectedDate = DateTime.now();
  int ds = 0;
  List<String> hobbieList = [];
  DatabaseHelper databaseHelper = DatabaseHelper();

  TextEditingController controllerHobie;

  changeHobbieText() {
    setState(() {
      controllerHobie = TextEditingController(text: "");
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
    _cropImage();
  }

  removeHobbie(int index) {
    setState(() {
      hobbieList.removeAt(index);
    });
  }

  getSelectedDate() {
    int day;
    int month;
    int year;
    day = selectedDate.day;
    month = selectedDate.month;
    year = selectedDate.year;
    String d, m;
    if (day < 10) {
      d = "0$day";
    } else {
      d = "$day";
    }
    if (month < 10) {
      m = "0$month";
    } else {
      m = "$month";
    }
    year = year % 100;
    return "$d/$m/$year";
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 50,
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        ds = 1;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        primary: true,
        shrinkWrap: true,
        children: [
          InkWell(
            onTap: () {
              _pickImage(ImageSource.gallery);
            },
            child: Center(
              child: Card(
                elevation: 10,
                child: Container(
                  height: 100,
                  width: 100,
                  child: Center(
                      child: _imageFile != null
                          ? Image.file(_imageFile)
                          : Text(
                        "No Image Selected",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: new InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
                filled: true,
                hintStyle: new TextStyle(color: Colors.grey[800]),
                hintText: "Email Address",
                fillColor: Colors.white70),
            onChanged: (text) {
              email = text;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: new InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
                filled: true,
                hintStyle: new TextStyle(color: Colors.grey[800]),
                hintText: "Password",
                fillColor: Colors.white70),
            onChanged: (text) {
              password = text;
            },
            obscureText: true,
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: new InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
                filled: true,
                hintStyle: new TextStyle(color: Colors.grey[800]),
                hintText: "Name",
                fillColor: Colors.white70),
            onChanged: (text) {
              userName = text;
            },
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              _selectDate(context);
            },
            child: new Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black54,
                ),
                borderRadius: BorderRadius.all(Radius.circular(
                    10.0) //                 <--- border radius here
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "${(ds == 0 ? "Date Of Birth" : getSelectedDate())}",
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: new InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
                filled: true,
                hintStyle: new TextStyle(color: Colors.grey[800]),
                hintText: "Hobbies",
                fillColor: Colors.white70),
            maxLines: null,
            controller: controllerHobie,
            onSubmitted: (value) {
              hobbieList.add(value);
              changeHobbieText();
            },
          ),
          SizedBox(
            height: 10,
          ),
          // ListView.builder(
          //   scrollDirection: Axis.horizontal,
          //   primary: false,
          //   itemCount: hobbieList.length,
          //   itemBuilder: (context, index) {
          //     return Card(
          //       child: Container(
          //         height: 50,
          //         child: Row(
          //           children: [
          //             Text("${hobbieList[index]}"),
          //             InkWell(
          //               onTap: (){
          //                 removeHobbie(index);
          //               },
          //               child: Icon(
          //                 Icons.close,
          //                 color: Colors.pink,
          //                 size: 24.0,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // ),
          RaisedButton(
            onPressed: () {
              saveData();
            },
            color: Colors.redAccent,
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  saveData() {
    if (email != null && userName != null && password !=null) {
      User u = new User(userName, password, email, dob, _imageFile.toString());
      Hobbies h = new Hobbies("hobbieList[0]", 1);
      databaseHelper.insertUser(u);
      databaseHelper.insertHobbie(h);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Login()));
    } else {
      _showAccountErrorDialog();
    }
  }

  void _showAccountErrorDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter all details"),
            content: Text("Select all details"),
            actions: <Widget>[
              FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }
}
