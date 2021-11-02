import 'package:chat_app/business/barItem/route/SearchListController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Card(
            margin: EdgeInsets.all(5),
            elevation: 0.5,
            child: Container(
              height: 40,
              alignment: Alignment.center,
              child: TextFormField(
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(fontSize: 15),
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintText: "微信号/手机号",
                ),
                onTap: () {
                  Get.to(SearchListPage(),
                      transition: Transition.fade,
                      duration: Duration(milliseconds: 500));
                },
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "我的微信号：zhd0704",
            ),
          )
        ],
      ),
    );
  }
}
