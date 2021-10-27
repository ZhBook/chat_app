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

    /// 当有接收新消息时，更新列表
    eventBus =
        EventBusUtils.getInstance().on<WebSocketUtility>().listen((event) {
      // if (mounted) {
      print("接收到了新的消息，进行渲染了");
      // initMsgList();
      // }
      Message newMessage = event.receiveMsg;
      setState(() {
        list.removeWhere((element) => element.friendId == newMessage.friendId);
        list.add(newMessage);
      });
    });
  }

  late StreamSubscription eventBus;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
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
    return GestureDetector(
      onTap: () async {
        ///调用本地数据查询聊天信息
        var msg =
            await DBManage.getMessages(message.friendId.toString(), 0, 20);
        var userInfo = await UserInfoUtils.getUserInfo();

        /// 跳转到聊天界面
        Get.to(ChatPage(), arguments: [msg, message.friendId, userInfo]);
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.network(
                  message.headImgUrl,
                  fit: BoxFit.fill,
                  width: 40,
                  height: 40,
                ),
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
                      child: Text("联系人",
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
