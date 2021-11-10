import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

EdgeInsetsGeometry _padding = EdgeInsets.only(left: 15.0, right: 15.0);

class PersonInfoPage extends StatelessWidget {
  const PersonInfoPage({Key? key, required this.userInfo}) : super(key: key);
  final dynamic userInfo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ListView.builder(
          itemCount: 1,
          padding: const EdgeInsets.all(8.0),
          itemBuilder: personInfo,
        ),
      ),
    );
  }

  Widget personInfo(BuildContext context, int index) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          height: 120,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 60,
                  width: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(userInfo.headImgUrl)
                    // Image.network(userInfo.headImgUrl)
                    ,
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
                      SizedBox(
                        child: Text(
                          userInfo.nickname,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        child: Text(
                          "微信号：" + userInfo.username,
                          style: TextStyle(color: Colors.black38),
                        ),
                      ),
                      SizedBox(
                        child: Text(
                          "地区：" + userInfo.address,
                          style: TextStyle(color: Colors.black38),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: _padding,
          color: Colors.white,
          height: 50,
          margin: EdgeInsets.only(top: 1.0),
          child: Row(children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Text("标签"),
              ),
            ),
            Container(
              child: Text("相逢大学"),
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
          margin: EdgeInsets.only(top: 1.0),
          child: Row(children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Text("朋友权限"),
              ),
            ),
            Container(
              child: Text(""),
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
              flex: 2,
              child: Container(
                child: Text("朋友圈"),
              ),
            ),
            Container(
              child: Text(""),
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
          margin: EdgeInsets.only(top: 1.0),
          child: Row(children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Text("更多信息"),
              ),
            ),
            Container(
              child: Text(""),
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
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.comment, color: Colors.blue),
            Text(
              "发消息",
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ]),
        ),
        Container(
          padding: _padding,
          color: Colors.white,
          height: 50,
          margin: EdgeInsets.only(top: 1.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.duo, color: Colors.blue),
            Text(
              "音视频通话",
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ]),
        ),
      ],
    );
  }
}
