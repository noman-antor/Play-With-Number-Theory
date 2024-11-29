import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'datamodel.dart';
import 'dart:io';
import 'dart:async';

class Dbprovider{

  static Future <void> createTables(sql.Database database) async
  {
    await database.execute("""
           CREATE TABLE info
           (
              id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              fname Text,
              lname Text,
              username Text,
              email Text,
              password Text,
              birth_date Text,
              level Text,
              score Text,
              score_status Text,
              createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
           )"""
        );
  }
  static Future <sql.Database> db() async
  {
    return sql.openDatabase(
      "database_name.db",
      version: 3,
      onCreate: (sql.Database database, int version) async
      {
        await createTables(database);
      }
    );
  }
static Future<int> addItem(String fname,String lname,String username,String email,String password, String birth_date, String level, String score, String score_status) async
{
  final db = await Dbprovider.db();
  final data = {'fname' :fname,
                'lname' :lname,
                'username' :username,
                'email' :email,
                'password' :password,
                'birth_date' :birth_date,
                'level' :level,
                'score' :score,
                'score_status' :score_status,
  };
  final id = await db.insert('info', data,
  conflictAlgorithm: sql.ConflictAlgorithm.ignore);
  return id;
}

  static Future<List<dataModel>> readall() async //getting all user information
  {
    final db=await Dbprovider.db();
    final List<Map<String,dynamic>>maps;
    maps = await db.query("info");

    return List.generate(maps.length, (i){
      return dataModel(fname: maps[i]['fname'],
          lname: maps[i]['lname'],
          username: maps[i]['username'],
          email:maps[i]['email'],
          password: maps[i]['password'],
          bd: maps[i]['birth_date'],
          level: maps[i]['level'],
          score: maps[i]['score'],
          score_status: maps[i]['score_status']);
    });
  }

static Future<List<dataModel>> read(String username) async //only one user
{
  final db=await Dbprovider.db();
  final List<Map<String,dynamic>>maps;
  maps = await db.query("info", where: "username=?", whereArgs:[username] );

  return List.generate(maps.length, (i){
    return dataModel(fname: maps[i]['fname'],
        lname: maps[i]['lname'],
        username: maps[i]['username'],
        email:maps[i]['email'],
        password: maps[i]['password'],
        bd: maps[i]['birth_date'],
        level: maps[i]['level'],
        score: maps[i]['score'],
        score_status: maps[i]['score_status']);
  });
}

  static Future<List<dataModel>> read_email(String email) async //only one user
{
  final db=await Dbprovider.db();
  final List<Map<String,dynamic>>maps;
  maps = await db.query("info", where: "email=?", whereArgs:[email] );

  return List.generate(maps.length, (i){
    return dataModel(fname: maps[i]['fname'],
        lname: maps[i]['lname'],
        username: maps[i]['username'],
        email:maps[i]['email'],
        password: maps[i]['password'],
        bd: maps[i]['birth_date'],
        level: maps[i]['level'],
        score: maps[i]['score'],
        score_status: maps[i]['score_status']);
  });
}



static Future<int> updateinfo(String username, String level,String score,String score_status) async
{
  final db=await Dbprovider.db();
  final data ={
    'level':level,
    'score':score,
    'score_status' : score_status,
    'createdAt' : DateTime.now().toString()
  };
  return await db.update("info",data, where: "username=?",whereArgs: [username]);

}

  static Future<int> password_update(String email, String password) async
  {
    final db=await Dbprovider.db();
    final data ={
      'password':password,
      'createdAt' : DateTime.now().toString()
    };
    return await db.update("info",data, where: "email=?",whereArgs: [email]);

  }
}