import 'dart:async';

import 'package:chat_app/common/event/EventBusUtil.dart';
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
  DBManage(Message message);

  static void initDB() {
    getDatabasesPath().then((value) => databasesPath = value);
    log.info("数据库地址：" + databasesPath);
    openDatabase(database, onCreate: _onCreate, version: 7)
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
      "id" INTEGER(50) NOT NULL, "username" INTEGER(50), "nickname" TEXT(50),
      "headImgUrl" TEXT(1000), "EMail" TEXT(50), "mobile" TEXT(50),
      "sex" TEXT(4), "address" TEXT(255), PRIMARY KEY ("id") 
    );
      ''';

    String createRelationSQL = '''
    CREATE TABLE "user_relation" (
      "id" INTEGER(50) NOT NULL, "userId" INTEGER(50) NOT NULL, "friendId" INTEGER(50) NOT NULL,
      "friendNickname" TEXT(50), "friendHeadUrl" TEXT(1000), PRIMARY KEY ("id")
    );
      ''';

    String createChatting = '''
    CREATE TABLE "chatting" (
          "id" INTEGER(100) NOT NULL,
        "friendId" INTEGER(100) NOT NULL,
        "friendNickname" TEXT(100) NOT NULL,
        "userId" INTEGER(100) NOT NULL,
        "context" TEXT(1000),
        "url" TEXT(1000),
        "headImgUrl" TEXT(1000),
        "type" INTEGER(4),
        "createTime" TEXT(50) NOT NULL,
        "haveRead" INTEGER(4),
        "state" INTEGER(4),
        PRIMARY KEY ("friendId")
      );
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

  //更新最新聊天记录
  static Future updateChattingTable(Message message) async {
    var result = await db
        .query("chatting", where: "friendId =?", whereArgs: [message.friendId]);

    /// 如果记录不存在，则新增一条记录
    if (result.isEmpty) {
      return db.insert("chatting", message.toJson());
    } else {
      return db.update("chatting", message.toJson());
    }
  }

  static Future getFriend(num friendId) async {
    List<Map<String, dynamic>> result = await db
        .query("user_relation", where: "friendId =?", whereArgs: [friendId]);
    if (result.isEmpty) {
      return;
    }
    List<Friend> friends = result.map((e) => Friend.fromJson(e)).toList();
    return friends.first;
  }

  static Future<List<Friend>> selectFriends() async {
    List<Map<String, dynamic>> result =
        await db.query("user_relation", orderBy: "friendNickname asc");
    List<Friend> friends = result.map((e) => Friend.fromJson(e)).toList();
    return friends;
  }

  /// 存储接收到的消息
  static Future updateReceiveMessage(Message message) async {
    Batch batch = db.batch();
    var userId = message.userId;

    batch.insert("chat_$userId", message.toJson());

    var result = await db.query("chatting",
        where: "friendId =? or userId = ?",
        whereArgs: [message.userId, message.userId]);

    /// todo 区分用户和朋友发的消息
    var json = message.toJson();
    Message messageOther = Message.fromJson(json);

    num userID = messageOther.userId;
    messageOther.userId = messageOther.friendId;
    messageOther.friendId = userID;

    /// 如果记录不存在，则新增一条记录
    if (result.isEmpty) {
      batch.insert("chatting", messageOther.toJson());
    } else {
      batch.update("chatting", messageOther.toJson());
    }
    batch.commit();

    EventBusUtils.getInstance().fire(DBManage(message));
  }

  /// 存储发送的消息
  static Future updateSendMessage(Message message) async {
    Batch batch = db.batch();
    var result = await db
        .query("chatting", where: "friendId =?", whereArgs: [message.friendId]);

    /// 如果记录不存在，则新增一条记录
    if (result.isEmpty) {
      batch.insert("chatting", message.toJson());
    } else {}
    batch.update("chatting", message.toJson());

    var friendId = message.friendId;
    batch.insert("chat_$friendId", message.toJson());
    batch.commit();

    EventBusUtils.getInstance().fire(DBManage(message));
  }

  /// 降序查出所有聊天好友
  static Future<List<Message>> getChattingInfo() async {
    List<Map<String, dynamic>> result =
        await db.query("chatting", orderBy: "createTime asc");
    List<Message> message = result.map((e) => Message.fromJson(e)).toList();
    return message;
  }

  //通过好友的username创建与其相关的聊天表
  static Future createFriendsMessageTable(String friendId) async {
    log.info("开始创建好友聊天表，好友username:" + friendId);
    try {
      db.query("chat_$friendId");
      return true;
    } catch (e) {
      String createSQL = '''
     CREATE TABLE "chat_$friendId" (
        "id" INTEGER(100) NOT NULL,
        "friendId" INTEGER(100) NOT NULL,
        "friendNickname" TEXT(100) NOT NULL,
        "userId" INTEGER(100) NOT NULL,
        "context" TEXT(1000),
        "url" TEXT(1000),
        "headImgUrl" TEXT(1000),
        "type" INTEGER(4),
        "createTime" TEXT(255) NOT NULL,
        "haveRead" INTEGER(4),
        "state" INTEGER(4),
        PRIMARY KEY ("id")
      );
      ''';
      db.execute(createSQL);
      log.info("chat_$friendId聊天表创建成功");
    }
  }

  ///添加好友列表
  static Future<bool> addFriends(List<Friend> list) async {
    Batch batch = db.batch();
    list.forEach((element) async {
      createFriendsMessageTable(element.friendId.toString());
      try {
        var check = await db
            .query("user_relation", where: "id =?", whereArgs: [element.id]);

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
    print('查询聊天信息' + friendId);
    createFriendsMessageTable(friendId);
    List<Map<String, dynamic>> result = await db.query("chat_$friendId",
        orderBy: 'createTime desc', limit: 20, offset: 0);
    List<Message> message = result.map((e) => Message.fromJson(e)).toList();
    return message;
  }

  ///分页获取与好友的聊天信息
  static Future<List<Message>> getNextMessages(
      String friendId, num messageId) async {
    print('查询聊天信息' + friendId);
    createFriendsMessageTable(friendId);
    String sql = '''
    SELECT * FROM "chat_$friendId" WHERE id < $messageId  ORDER BY createTime DESC LIMIT 5
    ''';
    List<Map<String, dynamic>> result = await db.rawQuery(sql);
    List<Message> message = result.map((e) => Message.fromJson(e)).toList();
    return message;
  }

  //新消息接收时，写入对应的表中
  static Future insertMessage(Message message) async {
    var friendId = message.friendId.toString();
    // createFriendsMessageTable(friendId);
    db.insert("chat_$friendId", message.toJson());
  }

  static Future<int> selectUnReadMessage(num friendId) async {
    List<Map<String, Object?>> list =
        await db.query("chat_$friendId", where: "haveRead =?", whereArgs: [1]);
    return list.length;
  }

  static Future updateUnReadMessage(num friendId) async {
    await db.update("chat_$friendId", {"haveRead": 0},
        where: "haveRead =?", whereArgs: [1]);
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
