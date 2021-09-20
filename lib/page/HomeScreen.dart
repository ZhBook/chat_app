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
              return Container(
                padding: EdgeInsets.only(
                  left: 5.0,
                ),
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: Icon(
                        Icons.person_add_outlined,
                        size: 50,
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text("用户$index",
                                style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      index % 2 == 0 ? Colors.red : Colors.blue,
                                )),
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "聊天信息预览$index",
                                style: TextStyle(color: Colors.amber),
                              )),
                        ],
                      ),
                      flex: 7,
                    ),
                    Expanded(
                        child: Container(
                      alignment: Alignment.centerRight,
                      child: Text("14.30"),
                    ))
                  ],
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
