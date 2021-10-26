import 'dart:async';

import 'package:chat_app/models/friend.dart';
import 'package:chat_app/models/message.dart';
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
    log.info("数据库地址：" + databasesPath);
    openDatabase(database, onCreate: _onCreate, version: 6)
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
    String createUserInfoSQL = '''
    CREATE TABLE "user_info" (
      "id" TEXT(255) NOT NULL, "username" TEXT(255), "nickname" TEXT(255),
      "headImgUrl" TEXT(1000), "EMail" TEXT(255), "mobile" TEXT(255),
      "sex" TEXT(255), "address" TEXT(255), PRIMARY KEY ("id") 
    );
      ''';

    String createRelationSQL = '''
    CREATE TABLE "user_relation" (
      "id" TEXT(255) NOT NULL, "userId" TEXT(255) NOT NULL, "friendId" TEXT(255) NOT NULL,
      "friendName" TEXT(255), "friendHeadUrl" TEXT(1000), PRIMARY KEY ("id","userId","friendId")
    );
      ''';

    String createChatting = '''
    CREATE TABLE "chatting" (
      "id" INTEGER NOT NULL,"userId" INTEGER(20) NOT NULL,"friendId" INTEGER(20) NOT NULL,
      "context" TEXT(1000),"headImgUrl" TEXT(1000),"url" TEXT(1000),
      "type" integer(4),"updateTime" DATE,"haveRead" integer(4),"state" integer(4),
      PRIMARY KEY ("id", "userId")
    );
    ''';
    Batch batch = db.batch();
    batch.execute(createUserInfoSQL);

    /// 创建好友关系表
    batch.execute(createRelationSQL);

    /// 创建当前聊天记录表
    batch.execute(createChatting);
    batch.commit();
    log.info("数据库表创建成功");
  }

  //通过好友的username创建与其相关的聊天表
  static Future createFriendsMessageTable(String friendId) async {
    log.info("开始创建好友聊天表，好友username:" + friendId);
    try {
      List<Map<String, dynamic>> result = await db.query("chat_$friendId");
      if (result.isNotEmpty) {
        return true;
      }
    } catch (e) {
      log.warning(e);
    }
    String createSQL = '''
     CREATE TABLE "chat_$friendId" (
        "id" INTEGER(100) NOT NULL,
        "friendId" INTEGER(100) NOT NULL,
        "userId" INTEGER(100) NOT NULL,
        "context" TEXT(1000),
        "url" TEXT(1000),
        "headImgUrl" TEXT(1000),
        "type" INTEGER(4),
        "createTime" TEXT(255) NOT NULL,
        "haveRead" INTEGER(4),
        "state" INTEGER(4),
        PRIMARY KEY ("id", "friendId", "userId")
      );
      ''';
    db.execute(createSQL);
    log.info("chat_$friendId聊天表创建成功");
  }

  ///添加好友列表
  static Future<bool> addFriends(List<Friend> list) async {
    Batch batch = db.batch();
    list.forEach((element) async {
      createFriendsMessageTable(element.friendId.toString());
      try {
        var check = await db
            .query("user_relation", where: "id", whereArgs: [element.id]);

        ///todo 需要处理好友信息修改后的问题
        if (check.isNotEmpty) {
          return;
        }
      } catch (e) {
        log.info("好友记录已存在：" + element.id.toString());
      }

      ///todo 好友关系已存在
      batch.insert("user_relation", element.toJson());
    });
    batch.commit();
    return true;
  }

  ///分页获取与好友的聊天信息
  static Future<List<Message>> getMessages(
      String friendId, int start, int limit) async {
    createFriendsMessageTable(friendId);
    List<Map<String, dynamic>> result = await db.query("chat_$friendId",
        distinct: true,
        orderBy: 'createTime desc',
        limit: limit,
        offset: start);
    List<Message> message = result.map((e) => Message.fromJson(e)).toList();
    return message;
  }

  static Future insertMessage(Message message) async {
    var friendId = message.friendId.toString();
    // createFriendsMessageTable(friendId);
    db.insert("chat_$friendId", message.toJson());
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
