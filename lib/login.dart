import 'package:demo/register.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'main.dart';
import 'util/DatabaseHelper.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String userName, password;
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 2.0, spreadRadius: 1),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8),
                  child: TextField(
                    onChanged: (text) {
                      userName = text;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'User Id',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 2.0, spreadRadius: 1),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8),
                  child: TextField(
                    onChanged: (text) {
                      password = text;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              RaisedButton(
                onPressed: () {
                  checkLogin();
                },
                color: Colors.redAccent,
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Register()));
                },
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  checkLogin() async {
    DatabaseHelper databaseHelper = new DatabaseHelper();
    int x = await databaseHelper.checkAccountLogin("$userName", "$password");

    if (x > 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      _showLoginErrorDialog();
    }
  }

  void _showLoginErrorDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Login Failed"),
            content: Text("Enter correct User Name and password to Login."),
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
