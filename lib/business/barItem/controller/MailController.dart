import 'package:chat_app/business/barItem/route/ChattingController.dart';
import 'package:chat_app/business/barItem/route/NewFriendController.dart';
import 'package:chat_app/business/barItem/route/SearchController.dart';
import 'package:chat_app/common/Controller.dart';
import 'package:chat_app/common/database/DBManage.dart';
import 'package:chat_app/common/utils/UserInfoUtils.dart';
import 'package:chat_app/models/friend.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MailScreen extends StatefulWidget {
  const MailScreen({Key? key}) : super(key: key);

  @override
  _MailScreenState createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {
  List<Friend> friendList = [];
  double _iconSize = 25;
  @override
  void initState() {
    super.initState();
    DBManage.selectFriends().then((value) {
      setState(() {
        friendList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(Controller());
    return Scaffold(
      appBar: AppBar(
        title: Text("通讯录"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(SearchPage());
            },
            icon: Icon(Icons.person_add_alt),
          )
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
                    child: GestureDetector(
                      onTap: () {
                        Get.to(NewFriend());
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Icon(
                              Icons.supervisor_account,
                              size: _iconSize,
                              color: Colors.orangeAccent,
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              "新的朋友",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 0.5,
                    indent: 64.0,
                    endIndent: 20,
                    color: Colors.grey[300],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    height: 45,
                    child: Row(
                      children: [
                        Expanded(
                          child: Icon(
                            Icons.perm_identity,
                            size: _iconSize,
                            color: Colors.orangeAccent,
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 5,
                          child: Text("仅聊天的朋友"),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 0.5,
                    indent: 64.0,
                    endIndent: 20,
                    color: Colors.grey[300],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    height: 45,
                    child: Row(
                      children: [
                        Expanded(
                          child: Icon(
                            Icons.people,
                            size: _iconSize,
                            color: Colors.green,
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 5,
                          child: Text("群聊"),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 0.5,
                    indent: 64.0,
                    endIndent: 20,
                    color: Colors.grey[300],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    height: 45,
                    child: Row(
                      children: [
                        Expanded(
                          child: Icon(
                            Icons.bookmark_add,
                            size: _iconSize,
                            color: Colors.blue,
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 5,
                          child: Text("标签"),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 0.5,
                    indent: 64.0,
                    endIndent: 20,
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
                          child: Icon(
                            Icons.perm_identity,
                            size: _iconSize,
                            color: Colors.blue,
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 5,
                          child: Text("公众号"),
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
                childCount: friendList.length),
            itemExtent: 48.0,
          )
        ],
      )),
    );
  }

  Widget _cellForRow(BuildContext context, int index) {
    Friend friend = friendList[index];
    return GestureDetector(
      onTap: () async {
        print("点击了$friend");

        ///调用本地数据查询聊天信息
        var msg = await DBManage.getMessages(friend.friendId.toString(), 0, 20);
        var userInfo = await UserInfoUtils.getUserInfo();
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
        padding: EdgeInsets.only(left: 20.0, right: 10.0),
        height: 45,
        child: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  friend.friendHeadUrl,
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
              ),
              flex: 1,
            ),
            Expanded(
              flex: 9,
              child: Container(
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Text(friend.friendNickname),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _childCount() {
    if (null == Controller.to.friendList) {
      return 0;
    }
    friendList = Controller.to.friendList;
    return Controller.to.friendList.length;
  }
}
