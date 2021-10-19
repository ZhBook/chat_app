import 'dart:async';

import 'package:sqflite/sqflite.dart';

///数据库管理类
class DBManage {
  static late Database db;
  static String databasesPath = "";
  static String database = "DB/chatApp.db";

  static Future<void> initDB() async {
    databasesPath = await getDatabasesPath();
    print(databasesPath);
    db = await openDatabase(database, onCreate: _onCreate, version: 1);
  }

  //建表
  static Future<void> _onCreate(Database db, int version) async {
    Future<bool> isExists = databaseExists(database);
    bool isTure = isExists.asStream().isBroadcast;
    print("结果是：" + isTure.toString());
    if (isExists.asStream().isBroadcast) {
      return;
    }
    String createSQL = '''
    CREATE TABLE "user_info" (
      "id" TEXT(255) NOT NULL, "username" TEXT(255), "nickname" TEXT(255),
      "head_img_url" TEXT(255), "e_mail" TEXT(255), "mobile" TEXT(255),
      "sex" TEXT(255), "address" TEXT(255), PRIMARY KEY ("id") 
    );
      ''';
    db.execute(createSQL);
    print("创建成功");
  }

  //通过好友的username创建与其相关的聊天表
  Future createFriendsMessageTable(String friendUsername) async {
    String createSQL = '''
    CREATE TABLE "chat_$friendUsername" ( 
      "id" TEXT(255) NOT NULL, "send_id" TEXT(255) NOT NULL,
      "receive_id" TEXT(255) NOT NULL, "context" TEXT(255), "resource_url" TEXT(255),
      "voice" TEXT(255), "is_revoke" TEXT(255), "create_time" TEXT(255),
    PRIMARY KEY ("id", "send_id", "receive_id"));
      ''';
    db.execute(createSQL);
  }

  //创建用户信息表
  Future createUserInfoTable() async {
    String createSQL = '''
    CREATE TABLE "user_info" (
      "id" TEXT(255) NOT NULL, "username" TEXT(255), "nickname" TEXT(255),
      "head_img_url" TEXT(255), "e_mail" TEXT(255), "mobile" TEXT(255),
      "sex" TEXT(255), "address" TEXT(255), PRIMARY KEY ("id") 
    );
      ''';
    db.execute(createSQL);
  }

  //创建好友信息表
  Future createFriendsTable() async {
    String createSQL = '''
    CREATE TABLE "user_relation" (
      "id" TEXT(255) NOT NULL, "user_id" TEXT(255) NOT NULL, "friend_id" TEXT(255) NOT NULL,
      "friend_name" TEXT(255), "friend_head_url" TEXT(255), PRIMARY KEY ("id","user_id","friend_id")
    );
      ''';
    db.execute(createSQL);
  }

  Future query(Database db) async {
    // Get the records
    List<Map> list = await db.rawQuery('SELECT * FROM Test');
    List<Map> expectedList = [
      {'name': 'updated name', 'id': 1, 'value': 9876, 'num': 456.789},
      {'name': 'another name', 'id': 2, 'value': 12345678, 'num': 3.1416}
    ];
    print(list);
    print(expectedList);
  }

  Future update(Database db) async {
    // Update some record
    int count = await db.rawUpdate(
        'UPDATE Test SET name = ?, value = ? WHERE name = ?',
        ['updated name', '9876', 'some name']);
    print('updated: $count');
  }

  Future delete(Database db) async {
    // Delete a record
    int count =
        await db.rawDelete('DELETE FROM Test WHERE name = ?', ['another name']);
    assert(count == 1);
  }
}
