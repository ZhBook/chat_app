import 'package:chat_app/business/barItem/route/ChattingController.dart';
import 'package:chat_app/common/database/DBManage.dart';
import 'package:chat_app/common/event/EventBusUtil.dart';
import 'package:chat_app/common/network/WebSocketManage.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    /// 初始化数据
    initMsgList();

    /// 当有接收新消息时，更新列表
    EventBusUtils.getInstance().on<WebSocketUtility>().listen((event) {
      setState(() {
        initMsgList();
      });
    });
  }

  /// 初始化聊天记录
  void initMsgList() {
    DBManage.getChattingInfo().then((value) => list = value);
  }

  @override
  Widget build(BuildContext context) {
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
        /// 跳转到聊天界面
        Get.to(ChatPage(), arguments: [message, message.friendId]);
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
              child: Container(
                child: Icon(
                  Icons.person_pin,
                  size: 50,
                  color: Colors.amber,
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
              child:
                  Text(Utils.getRandomNum(24) + ":" + Utils.getRandomNum(60)),
            ))
          ],
        ),
      ),
    );
  }
}
