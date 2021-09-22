import 'package:flutter/material.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //内边距
    EdgeInsetsGeometry _padding = EdgeInsets.only(left: 10.0, right: 10.0);

    //背景颜色
    Color _modelColor = Colors.white;

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
                  flex: 1,
                  child: Container(
                    child: Icon(
                      Icons.camera_rounded,
                      size: 30,
                      color: Colors.red,
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
                      Icons.search,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Text("扫一扫"),
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
//摇一摇
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
                      Icons.connect_without_contact,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Text("摇一摇"),
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

//看一看
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
                      Icons.watch_later_outlined,
                      size: 30,
                      color: Colors.orange,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Text("看一看"),
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
//搜一搜
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
                      Icons.rotate_right,
                      size: 30,
                      color: Colors.red,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Text("搜一搜"),
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
//直播和附近
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
                      Icons.share_location_rounded,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Text("直播和附近"),
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
//小程序
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
                      Icons.paid_sharp,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Text("小程序"),
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
          ],
        ),
      ),
    ));
  }
}
