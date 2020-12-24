import 'dart:async';
import 'dart:io';
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
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tblMemMast (id INTEGER PRIMARY KEY,code INTEGER, name TEXT, brancode INTEGER, totalcow INTEGER, totalbuf INTEGER, mobile TEXT)');

  }

  // Fetch Operation: Get all todo objects from database
  Future<List<Map<String, dynamic>>> getMemMapList() async {
    Database db = await this.database;
    var result = await db.query('$tblMemMast');
    return result;
  }

  Future<List<Map<String, dynamic>>> getGLMapList() async {
    Database db = await this.database;
    var result = await db.query('GL');
    return result;
  }
  Future<List<Map<String, dynamic>>> getCollectionMapList() async {
    Database db = await this.database;

    var result = await db.query('PCRX');
    return result;
  }
  Future<List<Map<String, dynamic>>> getUserMapList() async {
    Database db = await this.database;
    var result = await db.query('ACCOUNT');
    return result;
  }

  // Insert Operation: Insert a todo object to database

  Future<int> insertUser(User user) async {
    Database db = await this.database;
    var result = await db.insert('user', user.toMap());
    return result;
  }

  checkAccountLogin(String user, String password) async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from user WHERE userid = "$user" AND pass = "$password"');
    int result = Sqflite.firstIntValue(x);

    return result;
  }
}
