import 'package:chat_app/Utils/Utils.dart';
import 'package:chat_app/route/Chating.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget divider1 = Divider(
      color: Colors.red,
      height: 0.5,
    );
    Widget divider2 = Divider(
      color: Colors.green,
      height: 0.5,
    );
    return Scaffold(
      body: Container(
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Container(
                  height: 40.0,
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.5,
                          color: Color.fromRGBO(157, 153, 153, 1.0))),
                  // padding: EdgeInsets.all(5.0),
                  child: TextField(
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: "搜索",
                        prefixIcon: Icon(Icons.find_in_page, size: 30),
                        border: InputBorder.none,
                      ),
                      textAlign: TextAlign.center),
                );
              }
              return GestureDetector(
                // behavior: HitTestBehavior.opaque,
                onTap: () async {
                  print("点击了$index");
                  await Navigator.of(context)
                      .pushNamed("chating_page", arguments: index);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Icon(
                            Icons.person_pin,
                            size: 50,
                            color: Utils.getRandomColor(),
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
                                child: Text(
                                    "联系人" +
                                        generateWordPairs()
                                            .take(1)
                                            .first
                                            .toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Utils.getRandomColor(),
                                    )),
                              ),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "聊天信息预览:" +
                                        generateWordPairs()
                                            .take(1)
                                            .first
                                            .toString(),
                                    style: TextStyle(
                                        color: Utils.getRandomColor()),
                                  )),
                            ],
                          ),
                        ),
                        flex: 7,
                      ),
                      Expanded(
                          child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(Utils.getRandomNum(24) +
                            ":" +
                            Utils.getRandomNum(60)),
                      ))
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return index % 2 == 0 ? divider1 : divider2;
            },
            itemCount: 100),
      ),
    );
  }
}
