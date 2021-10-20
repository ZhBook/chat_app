import 'dart:async';

import 'package:chat_app/models/friend.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:sqflite/sqflite.dart';

///数据库管理类
class DBManage {
  static late Database db;
  static String databasesPath = "";
  static String database = "DB/chatApp.db";
  static final log = SimpleLogger();

  static void initDB() {
    getDatabasesPath().then((value) => databasesPath = value);
    log.info(databasesPath);
    openDatabase(database, onCreate: _onCreate, version: 1)
        .then((value) => db = value);
  }

  //建表
  static Future<void> _onCreate(Database db, int version) async {
    bool isTure = false;
    Future<bool> isExists = databaseExists(database);
    isExists.then((value) => isTure = value);
    log.info("用户表user_info是否存在：" + isTure.toString());
    if (isTure) {
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
    log.info("用户表user_info创建成功");
  }

  //通过好友的username创建与其相关的聊天表
  static Future createFriendsMessageTable(String friendUsername) async {
    log.info("开始创建好友聊天表，好友username:" + friendUsername);
    String createSQL = '''
    CREATE TABLE "chat_$friendUsername" ( 
      "id" TEXT(255) NOT NULL, "send_id" TEXT(255) NOT NULL,
      "receive_id" TEXT(255) NOT NULL, "context" TEXT(255), "resource_url" TEXT(255),
      "voice" TEXT(255), "is_revoke" TEXT(255), "create_time" TEXT(255),
    PRIMARY KEY ("id", "send_id", "receive_id"));
      ''';
    db.execute(createSQL);
    log.info("好友列表创建成功");
  }

  //创建好友信息表
  static Future createFriendsTable() async {
    log.info("创建好友关系表");
    String createSQL = '''
    CREATE TABLE "user_relation" (
      "id" TEXT(255) NOT NULL, "user_id" TEXT(255) NOT NULL, "friend_id" TEXT(255) NOT NULL,
      "friend_name" TEXT(255), "friend_head_url" TEXT(255), PRIMARY KEY ("id","user_id","friend_id")
    );
      ''';
    db.execute(createSQL);
    log.info("好友关系表成功");
  }

  static Future<int> addFriends(List<Friend> list) async {
    String sql = '''
    INSERT INTO user_relation( id , user_id, friend_id, friend_name, friend_head_url) VALUES(?,?,?,?,?)
    ''';
    return db.rawInsert(sql, list);
  }

  Future query(Database db) async {
    // Get the records
    List<Map> list = await db.rawQuery('SELECT * FROM Test');
    List<Map> expectedList = [
      {'name': 'updated name', 'id': 1, 'value': 9876, 'num': 456.789},
      {'name': 'another name', 'id': 2, 'value': 12345678, 'num': 3.1416}
    ];
    log.info(list);
    log.info(expectedList);
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
