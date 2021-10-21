import 'package:chat_app/common/InitClass.dart';
import 'package:chat_app/common/utils/ProgressDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../exception/UnknownRoute.dart';
import '../../login/controller/LoginController.dart';
import '../../login/route/DrawerController.dart';
import '../../moments/controller/MomentController.dart';
import '../route/ChattingController.dart';
import '../route/ScanController.dart';
import '../route/SettingController.dart';
import 'HomeController.dart';
import 'MailController.dart';
import 'PersonController.dart';
import 'ToolsController.dart';

class Index extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    //初始化
    InitClass.init();

    return GetMaterialApp(
      title: 'ChatApp',
      theme: ThemeData(
        splashColor: Colors.transparent, //去掉水波纹效果
      ),
      home: LoginPage(),
      unknownRoute: GetPage(
          page: () {
            return UnknownRoute();
          },
          name: '/notfound'),
      routes: {
        "login_page": (context) => LoginPage(),
        "chat_page": (context) => ChatPage(),
        "friends_page": (context) => Friends(),
        "home": (context) => ScaffoldRoute(),
        "scan_page": (context) => ScanPage(),
        "setting_page": (context) => Setting(),
      },
    );
  }
}

class ScaffoldRoute extends StatefulWidget {
  @override
  _ScaffoldRouteState createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<ScaffoldRoute>
    with SingleTickerProviderStateMixin {
  List tabs = ["微信", "通讯录", "发现", "我"];

  List<Widget> list = [];

  Text _title = Text("微信");

  int _selectedIndex = 0;

  late TabController _tabController;

  //用于控制右上角图标
  var _rightIcon = Icon(Icons.add_circle_outlined);

  //用于控制右上角图标的显示
  bool _rightCtrl = true;

  bool _loading = false;

  //标题栏主题颜色
  // Color _backgroundColor = Color.fromRGBO(223, 224, 225, 1.0);

/*   @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  } */

  @override
  void initState() {
    list
      ..add(HomeScreen())
      ..add(MailScreen())
      ..add(ToolsScreen())
      ..add(PersonScreen());

    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);

    _tabController.addListener(() {
      switch (_tabController.index) {
        case 0:
          Container(
            child: Text("微信1"),
          );
          print("11");
          break;
        case 1:
          Container(
            child: Text("通信录1"),
          );
          print("22");
          break;
        case 2:
          Container(
            child: Text("发现1"),
          );
          print("33 1");
          break;
        case 3:
          Container(
            child: Text("我1"),
          );
          print("44");
          break;
      }
    });
  }

  //点击按钮执行的事件
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; //
      switch (index) {
        case 0:
          _rightIcon = Icon(Icons.add_circle_outlined);
          _rightCtrl = true;
          _title = Text("微信");
          break;
        case 1:
          _rightIcon = Icon(Icons.person_add_alt_1);
          _rightCtrl = true;
          _title = Text("通讯录");
          break;
        case 2:
          _rightCtrl = false;
          _title = Text("发现");
          break;
        case 3:
          _rightCtrl = false;
          _title = Text("");
          break;
      }
    });
    print(index);
  }

  void _onAdd() {
    print("加号按钮");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: _backgroundColor,
        title: _title,
        actions: <Widget>[
          //控制右上角按钮的显示
          Visibility(
            child: IconButton(
                onPressed: () async {
                  await _rightEvent();
                },
                icon: _rightIcon),
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: _rightCtrl,
          ),
        ], //右上角分享图标
        /* bottom: TabBar(
            //生成顶部Tab菜单
            controller: _tabController,
            tabs: tabs
                .map((e) => Tab(
                      text: e,
                    ))
                .toList(),
          ), */
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.dashboard,
              color: Colors.white,
            ),
          );
        }),
      ),
      drawer: new MyDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        // showSelectedLabels: true, //选中才显示文字
        showUnselectedLabels: true,
        unselectedItemColor: Color.fromRGBO(100, 102, 102, 1.0),
        backgroundColor: Colors.blue,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "微信"),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: "通信录"),
          BottomNavigationBarItem(icon: Icon(Icons.adjust_sharp), label: "发现"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "我"),
        ],
        currentIndex: _selectedIndex,
        //items的index
        fixedColor: Colors.blue,
        onTap: _onItemTapped, //底部菜单点击事件
      ),
      /* floatingActionButton: FloatingActionButton(
          //悬浮按钮
          child: Icon(Icons.add),
          onPressed: _rightEvent,
        ),*/
      body: ProgressDialog(
          loading: _loading, msg: '加载中', child: list[_selectedIndex]),
    );
  }

//右上角点击事件
  Future<void> _rightEvent() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: _title,
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('该功能正在开发中...'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('确定'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
