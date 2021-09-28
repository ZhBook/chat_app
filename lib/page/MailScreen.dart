import 'package:chat_app/utils/Utils.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class MailScreen extends StatelessWidget {
  const MailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Container(
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
                );
              }
              String name = generateWordPairs().take(1).first.toString();
              return GestureDetector(
                onTap: () async {
                  print("点击了$name");
                  await Navigator.of(context)
                      .pushNamed("chat_page", arguments: name);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  height: 45,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Icon(
                            Icons.person_pin,
                            size: 40,
                            color: Utils.getRandomColor(),
                          ),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(name),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Utils.getRandomColor(),
                height: 0.5,
              );
            },
            itemCount: 100),
      ),
    );
  }
}
