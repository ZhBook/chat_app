import 'package:chat_app/models/friend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

List<Friend> list = [];

class NewFriend extends StatelessWidget {
  const NewFriend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: NewFriendList(),
      ),
    );
  }
}

class NewFriendList extends StatefulWidget {
  const NewFriendList({Key? key}) : super(key: key);

  @override
  _NewFriendListState createState() => _NewFriendListState();
}

class _NewFriendListState extends State<NewFriendList> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }

  Widget _cellForRow(BuildContext context, int index) {
    return GestureDetector(
      child: Text("新的朋友"),
    );
  }
}
