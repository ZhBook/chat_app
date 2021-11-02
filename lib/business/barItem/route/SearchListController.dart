import 'package:chat_app/common/network/Api.dart';
import 'package:chat_app/common/network/impl/ApiImpl.dart';
import 'package:chat_app/models/friendInfo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchListPage extends StatefulWidget {
  const SearchListPage({Key? key}) : super(key: key);

  @override
  _SearchListPage createState() => _SearchListPage();
}

class _SearchListPage extends State<SearchListPage> {
  List<FriendInfo> friends = [];
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      if (_textController.text.isEmpty) {
        setState(() {
          friends.clear();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //开启沉浸式状态栏
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      // 沉浸式状态栏下的安全区域
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Card(
                      margin: EdgeInsets.all(5),
                      elevation: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        height: 40,
                        alignment: Alignment.center,
                        child: TextFormField(
                          controller: _textController,
                          autofocus: true,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: TextStyle(fontSize: 15),
                          decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            hintText: "微信号/手机号",
                          ),
                          onChanged: (value) {
                            searchFriend(value, 0, 10);
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        return Get.back();
                      },
                      child: Text("取消"),
                    ),
                  )
                ],
              ),
            ),
            SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(_cellForRow,
                  childCount: friends.length),
              itemExtent: 48.0,
            )
          ],
        ),
      ),
    );
  }

  Widget _cellForRow(BuildContext context, int index) {
    FriendInfo friend = friends[index];
    return GestureDetector(
      onTap: () async {},
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
        height: 60,
        child: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  friend.headImgUrl,
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
              ),
              flex: 1,
            ),
            Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Text(friend.nickname),
              ),
            ),
            Expanded(
              flex: 2,
              child: IconButton(
                  onPressed: () {
                    addFriend(friend.id);
                  },
                  icon: Icon(Icons.person_add_alt)),
            ),
          ],
        ),
      ),
    );
  }

  void searchFriend(String column, int start, int limit) {
    Api api = new ApiImpl();
    api.searchFriends(column, start, limit).then((value) {
      setState(() {
        friends = value;
      });
    });
  }

  void addFriend(num friendId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text('添加好友留言：'),
          content: TextFormField(
            maxLines: 2,
            autofocus: true,
            textAlign: TextAlign.center,
            decoration: new InputDecoration(
              labelText: "Enter msg",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(5),
                borderSide: new BorderSide(),
              ),
              //fillColor: Colors.green
            ),
            style: TextStyle(fontSize: 15),
            onTap: () {
              Get.to(SearchListPage(),
                  transition: Transition.fade,
                  duration: Duration(milliseconds: 500));
            },
          ),
          actions: <Widget>[
            new ElevatedButton(
              child: new Text("发送"),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }
}
