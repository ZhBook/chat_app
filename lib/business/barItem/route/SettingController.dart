import 'dart:io';

import 'package:chat_app/business/login/controller/LoginController.dart';
import 'package:chat_app/common/config/Global.dart';
import 'package:chat_app/common/network/Request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: SettingPage(),
    );
  }
}

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  EdgeInsetsGeometry _padding = EdgeInsets.only(left: 10.0, right: 10.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      heightFactor: 1.0,
      child: Container(
        color: Color.fromRGBO(223, 224, 225, 1.0),
        child: new ListView(
          children: [
            Container(
              padding: _padding,
              color: Colors.white,
              height: 50,
              margin: EdgeInsets.only(top: 10.0),
              child: Row(children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Text(
                      "账号与安全",
                      style: TextStyle(fontSize: 16),
                    ),
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
              child: Row(children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Text(
                      "青少年模式",
                      style: TextStyle(fontSize: 16),
                    ),
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
                  flex: 4,
                  child: Container(
                    child: Text(
                      "新消息通知",
                      style: TextStyle(fontSize: 16),
                    ),
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
              child: Row(children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Text(
                      "隐私",
                      style: TextStyle(fontSize: 16),
                    ),
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
              child: Row(children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Text(
                      "通用",
                      style: TextStyle(fontSize: 16),
                    ),
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
                  flex: 4,
                  child: Container(
                    child: Text(
                      "帮助",
                      style: TextStyle(fontSize: 16),
                    ),
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
              child: Row(children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Text(
                      "关于微信",
                      style: TextStyle(fontSize: 16),
                    ),
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
                  flex: 4,
                  child: Container(
                    child: Text(
                      "插件",
                      style: TextStyle(fontSize: 16),
                    ),
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
            GestureDetector(
              onTap: () {
                Get.off(LoginPage());
              },
              child: Center(
                child: Container(
                  padding: _padding,
                  color: Colors.white,
                  width: double.maxFinite,
                  height: 50,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "切换账号",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                /* Navigator.of(context).pushNamedAndRemoveUntil(
                    "login_page", (Route route) => false);*/
                //清除数据
                Global.netCache.cache.clear();
                Request.dio.options.headers.addAll({
                  HttpHeaders.authorizationHeader: Request.basic,
                });
                print("header: " + Request.dio.options.headers.toString());
                Get.off(LoginPage());
              },
              child: Center(
                child: Container(
                  padding: _padding,
                  color: Colors.white,
                  width: double.maxFinite,
                  height: 50,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "退出账号",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
