import 'dart:async';

import 'package:chat_app/business/barItem/route/ChattingController.dart';
import 'package:chat_app/common/database/DBManage.dart';
import 'package:chat_app/common/event/EventBusUtil.dart';
import 'package:chat_app/common/network/WebSocketManage.dart';
import 'package:chat_app/common/utils/DateUtils.dart';
import 'package:chat_app/common/utils/UserInfoUtils.dart';
import 'package:chat_app/common/utils/Utils.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//消息列表
List<Message> list = [];

//是否显示未读消息
double _opacity = 0;

///todo 未读数量控制
int unreadNum = 1;

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('HomeController初始化');

    /// 初始化数据
    initMsgList();

    EventBusUtils.getInstance().on<DBManage>().listen((event) {
      if (mounted) {
        initMsgList();
      }
    });

    /// 当有接收新消息时，更新列表
    eventBus =
        EventBusUtils.getInstance().on<WebSocketUtility>().listen((event) {
      print("接收到了新的消息，进行渲染了");
      Message newMessage = event.receiveMsg;
      if (mounted) {
        setState(() {
          _opacity = 1;
          list.removeWhere(
              (element) => element.friendId == newMessage.friendId);
          list.add(newMessage);
        });
      }
    });
  }

  late StreamSubscription eventBus;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        //关闭返回
        automaticallyImplyLeading: false,
        title: Text("聊天"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                AlertDialog(
                  title: Text("Title"),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: const <Widget>[
                        Text('该功能正在开发中...'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('确定'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
              icon: Icon(Icons.add_circle_outlined)),
        ],
      ),
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                height: 40.0,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 0.5, color: Color.fromRGBO(157, 153, 153, 1.0))),
                // padding: EdgeInsets.all(5.0),
                child: TextField(
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: "搜索",
                      prefixIcon: Icon(Icons.find_in_page, size: 30),
                      border: InputBorder.none,
                    ),
                    textAlign: TextAlign.center),
              ),
            ),
            SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(_cellForRow,
                  childCount: list.length),
              itemExtent: 48.0,
            )
          ],
        ),
      ),
    );
  }

  Widget _cellForRow(BuildContext context, int index) {
    Message message = list[index];
    var friend;

    /// 获取好友信息
    DBManage.getFriend(message.friendId).then((value) => friend = value);

    ///设置全部消息已读
    DBManage.selectUnReadMessage(message.friendId)
        .then((value) => unreadNum = value);
    return GestureDetector(
      onTap: () async {
        //更新全部消息为已读
        await DBManage.updateUnReadMessage(message.friendId);

        ///调用本地数据查询聊天信息
        var msg =
            await DBManage.getMessages(message.friendId.toString(), 0, 20);
        var userInfo = await UserInfoUtils.getUserInfo();
        setState(() {
          unreadNum = 0;
          _opacity = 0;
        });

        /// 跳转到聊天界面
        Get.to(ChatPage(), arguments: [msg, friend, userInfo]);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
        ),
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        height: 70,
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      message.headImgUrl,
                      fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Opacity(
                      opacity: _opacity,
                      // maintainState: true,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: new Text(
                          '$unreadNum', //通知数量
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(message.friendNickname,
                          style: TextStyle(
                            fontSize: 18,
                            color: Utils.getRandomColor(),
                          )),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          message.context,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Utils.getRandomColor()),
                        )),
                  ],
                ),
              ),
              flex: 7,
            ),
            Expanded(
                child: Container(
              alignment: Alignment.centerRight,
              child: Text(DateUtil.getNowTime(message.createTime)),
            ))
          ],
        ),
      ),
    );
  }

  /// 初始化聊天记录
  void initMsgList() {
    DBManage.getChattingInfo().then((value) {
      setState(() {
        list = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    print('Home被卸载了');
    // eventBus.cancel();
  }
}
