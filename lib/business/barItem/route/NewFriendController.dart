import 'package:chat_app/common/network/Api.dart';
import 'package:chat_app/common/network/impl/ApiImpl.dart';
import 'package:chat_app/models/friendRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

List<FriendRequest> list = [];
Api api = new ApiImpl();

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
  void initState() {
    init();
    super.initState();
  }

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
    FriendRequest request = list[index];
    return GestureDetector(
      onTap: () async {
        /// 跳转到资料界面
        // Get.to(ChatPage(), arguments: [request.sendUserId]);
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
                      request.sendHeadImgUrl,
                      fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                    ),
                  ),
                ],
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(request.sendUserNickname,
                          style: TextStyle(
                            height: 1.0,
                            fontSize: 16,
                          )),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          request.message,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            height: 1.0,
                            fontSize: 12,
                          ),
                        )),
                  ],
                ),
              ),
              flex: 7,
            ),
            Expanded(
              child: isNotAgree(request),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }

  init() async {
    api.getRequest().then((value) {
      setState(() {
        list = value;
      });
    });
  }

  Widget isNotAgree(FriendRequest request) {
    if (request.infoState == 0) {
      return GestureDetector(
        child: Text(
          "添加",
          style: TextStyle(color: Colors.blue),
        ),
        onTap: () {
          api.handleRequest(request.id, 1).then((value) {
            if (value) {
              FlutterToastr.show("添加成功", context,
                  duration: FlutterToastr.lengthShort,
                  position: FlutterToastr.bottom);
              init();
            }
          });
        },
      );
    }
    if (request.isAgree == 0) {
      return Text("已拒绝");
    }
    return Text("已添加");
  }
}
