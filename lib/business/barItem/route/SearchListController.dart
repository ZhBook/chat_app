import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchListPage extends StatelessWidget {
  const SearchListPage({Key? key}) : super(key: key);

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
                    autofocus: true,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: TextStyle(fontSize: 15),
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      hintText: "微信号/手机号",
                    ),
                    onChanged: (value) {
                      return;
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
    );
  }
}
