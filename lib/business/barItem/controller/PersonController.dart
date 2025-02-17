import 'dart:convert';

import 'package:chat_app/business/barItem/route/PersonInfoController.dart';
import 'package:chat_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

//内边距
EdgeInsetsGeometry _padding = EdgeInsets.only(left: 10.0, right: 10.0);

//背景颜色
Color _modelColor = Colors.white;

class PersonScreen extends StatelessWidget {
  const PersonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      heightFactor: 1.0,
      child: Container(
        color: Color.fromRGBO(223, 224, 225, 1.0),
        child: new ListView(
          children: [
            PersonInfo(),
            Container(
              padding: _padding,
              color: Colors.white,
              height: 50,
              margin: EdgeInsets.only(top: 10.0),
              child: Row(children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Icon(
                      Icons.add_task,
                      size: 30,
                      color: Colors.red,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Text("支付"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ),
                ),
              ]),
            ),
            Container(
              padding: _padding,
              color: Colors.white,
              height: 50,
              margin: EdgeInsets.only(top: 10.0),
              child: Row(children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Icon(
                      Icons.dashboard,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Text("收藏"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ),
                ),
              ]),
            ),
//朋友圈
            Container(
              padding: _padding,
              color: Colors.white,
              height: 50,
              margin: EdgeInsets.only(top: 1.0),
              child: Row(children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Icon(
                      Icons.sports_soccer,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Text("朋友圈"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ),
                ),
              ]),
            ),

//卡包
            Container(
              padding: _padding,
              color: Colors.white,
              height: 50,
              margin: EdgeInsets.only(top: 1.0),
              child: Row(children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Icon(
                      Icons.style,
                      size: 30,
                      color: Colors.orange,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Text("卡包"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ),
                ),
              ]),
            ),
//表情
            Container(
              padding: _padding,
              color: Colors.white,
              height: 50,
              margin: EdgeInsets.only(top: 1.0),
              child: Row(children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Icon(
                      Icons.tag_faces,
                      size: 30,
                      color: Colors.red,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Text("表情"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ),
                ),
              ]),
            ),
//设置
            GestureDetector(
              onTap: () {
                print("设置按钮被点击了");
                Navigator.of(context).pushNamed("setting_page");
              },
              child: Container(
                padding: _padding,
                color: Colors.white,
                height: 50,
                margin: EdgeInsets.only(top: 10.0),
                child: Row(children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Icon(
                        Icons.settings,
                        size: 30,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Text("设置"),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class PersonInfo extends StatefulWidget {
  const PersonInfo({Key? key}) : super(key: key);

  @override
  _PersonInfoState createState() => _PersonInfoState();
}

class _PersonInfoState extends State<PersonInfo> {
  User userInfo = new User();

  @override
  void initState() {
    //初始化数据
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _padding,
      color: Colors.white,
      height: 120,
      margin: EdgeInsets.only(top: 0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 60,
              width: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(userInfo.headImgUrl),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      userInfo.nickname,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    child: Text(
                      "微信号：" + userInfo.username,
                      style: TextStyle(color: Colors.black38),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Icon(Icons.qr_code),
                ),
                IconButton(
                  onPressed: () {
                    Get.to(
                      PersonInfoPage(
                        userInfo: userInfo,
                      ),
                    );
                  },
                  icon: Icon(Icons.arrow_forward_ios, size: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userinfo = prefs.getString("loginUserInfo");
    var userJson = json.decode(userinfo!);
    setState(() {
      userInfo = User.fromJson(userJson);
    });
  }
}
