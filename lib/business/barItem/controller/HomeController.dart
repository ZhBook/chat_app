import 'package:chat_app/common/utils/Utils.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              delegate: SliverChildBuilderDelegate(_cellForRow, childCount: 1),
              itemExtent: 48.0,
            )
          ],
        ),
      ),
    );
  }

  Widget _cellForRow(BuildContext context, int index) {
    return GestureDetector(
      onTap: () async {
        print("点击了$index");

        ///todo 添加当前聊天信息表
        await Navigator.of(context).pushNamed("chat_page", arguments: index);
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
                      child: Text("联系人",
                          style: TextStyle(
                            fontSize: 18,
                            color: Utils.getRandomColor(),
                          )),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "聊天信息预览:" +
                              generateWordPairs().take(1).first.toString(),
                          style: TextStyle(color: Utils.getRandomColor()),
                        )),
                  ],
                ),
              ),
              flex: 7,
            ),
            Expanded(
                child: Container(
              alignment: Alignment.centerRight,
              child:
                  Text(Utils.getRandomNum(24) + ":" + Utils.getRandomNum(60)),
            ))
          ],
        ),
      ),
    );
  }
}
