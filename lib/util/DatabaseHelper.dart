import 'dart:async';
import 'dart:io';
import 'package:demo/model/Hobbies.dart';
import 'package:demo/model/user.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path_provider/path_provider.dart';


class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'dbName.db';

    var accountDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return accountDatabase;
  }
String tblMemMast = "userMast";
  String tblHobbies = "hobbies";
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tblHobbies (id INTEGER PRIMARY KEY, userId INTEGER, hobby TEXT)');
    await db.execute(
        'CREATE TABLE $tblMemMast (id INTEGER PRIMARY KEY, name TEXT, email TEXT, pass TEXT, dob TEXT, img TEXT)');

  }

  // Insert Operation: Insert a todo object to database

  Future<int> insertUser(User user) async {
    Database db = await this.database;
    var result = await db.insert('$tblMemMast', user.toMap());
    return result;
  }

  Future<int> insertHobbie(Hobbies hobbies) async {
    Database db = await this.database;
    var result = await db.insert('$tblHobbies', hobbies.toMap());
    return result;
  }

  checkAccountLogin(String user, String password) async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $tblMemMast WHERE email = "$user" AND pass = "$password"');
    int result = Sqflite.firstIntValue(x);

    return result;
  }

}
