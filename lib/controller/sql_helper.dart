import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:aplikasi_pengelola_keuangan/model/usermodel.dart';

class DbHelper {
  static DbHelper? _dbHelper;
  static Database? _database;
  DbHelper._createObject();

  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}finplan.db';

    //create, read databases
    var itemDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    return itemDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT,
    password TEXT
  )''');

    await db.execute('''
    CREATE TABLE finance (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT,
    amount TEXT,
    description TEXT,
    type TEXT
  )''');

    // insert to table user
    await db
        .insert("user", {'username': 'rena@mail.co', 'password': 'password'});
  }

  //* User
  //create databases user
  Future<int> insertUser(User object) async {
    Database db = await this.database;
    int count = await db.insert('user', object.toMap());
    return count;
  }

  // create login user return true or false
  Future<bool> loginUser(String username, String password) async {
    Database db = await this.database;

    List<Map<String, dynamic>> result = await db.query('user',
        where: 'username = ? AND password = ?', whereArgs: [username, password]);
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  // create change password
  Future<int> changePassword(String username, String password) async {
    Database db = await this.database;

    int result = await db.rawUpdate(
        'UPDATE user SET password = ? WHERE username = ?', [password, username]);
    return result;
  }

  // get user login data
  Future<List<User>> getUserLogin(String username) async {
    Database db = await this.database;
    List<Map<String, dynamic>> result =
        await db.query('user', where: 'username = ?', whereArgs: [username]);

    List<User> users = [];
    for (var i = 0; i < result.length; i++) {
      users.add(User.fromMap(result[i]));
    }
    return users;
  }

  // Add this method to DbHelper
  Future<User?> getUserByusername(String username) async {
    Database db = await this.database;
    List<Map<String, dynamic>> result =
        await db.query('user', where: 'username = ?', whereArgs: [username]);

    if (result.isNotEmpty) {
      return User.fromMap(result[0]);
    } else {
      return null;
    }
  }



  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database!;
  }
}
