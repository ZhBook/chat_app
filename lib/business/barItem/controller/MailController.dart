import 'package:chat_app/business/barItem/route/ChattingController.dart';
import 'package:chat_app/common/Controller.dart';
import 'package:chat_app/common/database/DBManage.dart';
import 'package:chat_app/models/friend.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MailScreen extends StatelessWidget {
  const MailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(Controller());
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
                  width: 0.5,
                  color: Color.fromRGBO(157, 153, 153, 1.0),
                ),
              ),
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
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    height: 45,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Icon(
                              Icons.supervisor_account,
                              size: 40,
                              color: Colors.orangeAccent,
                            ),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "新的朋友",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 0.5,
                    indent: 64.0,
                    color: Colors.grey[300],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    height: 45,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Icon(
                              Icons.perm_identity,
                              size: 40,
                              color: Colors.orangeAccent,
                            ),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text("仅聊天的朋友"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 0.5,
                    indent: 64.0,
                    color: Colors.grey[300],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    height: 45,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Icon(
                              Icons.people,
                              size: 40,
                              color: Colors.green,
                            ),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text("群聊"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 0.5,
                    indent: 64.0,
                    color: Colors.grey[300],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    height: 45,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Icon(
                              Icons.bookmark_add,
                              size: 40,
                              color: Colors.blue,
                            ),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text("标签"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 0.5,
                    indent: 64.0,
                    color: Colors.grey[300],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 0.5,
                          color: Color.fromRGBO(157, 153, 153, 1.0),
                        ),
                      ),
                    ),
                    height: 45,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Icon(
                              Icons.perm_identity,
                              size: 40,
                              color: Colors.blue,
                            ),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text("公众号"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(_cellForRow,
                childCount: null == Controller.to.friendList
                    ? 0
                    : Controller.to.friendList.length),
            itemExtent: 48.0,
          )
        ],
      )),
    );
  }

  Widget _cellForRow(BuildContext context, int index) {
    Friend friend = Controller.to.friendList[index];
    return GestureDetector(
      onTap: () async {
        print("点击了$friend");

        ///调用本地数据查询聊天信息

        var megs =
            await DBManage.getMessages(friend.friendId.toString(), 0, 20);
        Get.to(ChatPage(), arguments: [megs, friend]);
        /*await Navigator.of(context)
            .pushNamed("chat_page", arguments: friend.friendName);*/
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
        height: 45,
        child: Row(
          children: [
            Expanded(
              child: Container(
                  child: Image.network(
                friend.friendHeadUrl,
                height: 40,
                width: 40,
              )),
              flex: 1,
            ),
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(friend.friendName),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
