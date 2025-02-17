import 'dart:convert';

import 'package:chat_app/common/Controller.dart';
import 'package:chat_app/common/InitClass.dart';
import 'package:chat_app/common/event/EventBusUtil.dart';
import 'package:chat_app/common/network/WebSocketManage.dart';
import 'package:chat_app/models/friend.dart';
import 'package:chat_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../exception/UnknownRoute.dart';
import '../../login/controller/LoginController.dart';
import '../../login/route/DrawerController.dart';
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
        "home": (context) => ScaffoldRoute(),
        "scan_page": (context) => ScanPage(),
        "setting_page": (context) => Setting(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class ScaffoldRoute extends StatefulWidget {
  @override
  _ScaffoldRouteState createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<ScaffoldRoute>
    with TickerProviderStateMixin {
  // @override
  // bool get wantKeepAlive => true;

  List tabs = ["微信", "通讯录", "发现", "我"];

  List<Widget> list = [];

  Text _title = Text("微信");

  int _selectedIndex = 0;
  User userInfo = User();
  late TabController _tabController;

  //用于控制右上角图标
  var _rightIcon = Icon(Icons.add_circle_outlined);

  //用于控制右上角图标的显示
  bool _rightCtrl = true;

  bool _loading = false;

  var _futureBuilderFuture;

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
    _futureBuilderFuture = initData();

    list
      ..add(HomeScreen())
      ..add(MailScreen())
      ..add(ToolsScreen())
      ..add(PersonScreen());

    super.initState();
    // _tabController = TabController(length: tabs.length, vsync: this);

    // _tabController.addListener(() {
    //   switch (_tabController.index) {
    //     case 0:
    //       Container(
    //         child: Text("微信1"),
    //       );
    //       print("11");
    //       break;
    //     case 1:
    //       Container(
    //         child: Text("通信录1"),
    //       );
    //       print("22");
    //       break;
    //     case 2:
    //       Container(
    //         child: Text("发现1"),
    //       );
    //       print("33 1");
    //       break;
    //     case 3:
    //       Container(
    //         child: Text("我1"),
    //       );
    //       print("44");
    //       break;
    //   }
    // });
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
        // appBar: AppBar(
        //   centerTitle: true,
        //   // backgroundColor: _backgroundColor,
        //   title: _title,
        //   actions: <Widget>[
        //     //控制右上角按钮的显示
        //     Visibility(
        //       child: IconButton(
        //           onPressed: () async {
        //             await _rightEvent();
        //           },
        //           icon: _rightIcon),
        //       maintainSize: true,
        //       maintainAnimation: true,
        //       maintainState: true,
        //       visible: _rightCtrl,
        //     ),
        //   ], //右上角分享图标
        //   /* bottom: TabBar(
        //     //生成顶部Tab菜单
        //     controller: _tabController,
        //     tabs: tabs
        //         .map((e) => Tab(
        //               text: e,
        //             ))
        //         .toList(),
        //   ), */
        //   leading: Builder(builder: (context) {
        //     return IconButton(
        //       onPressed: () {
        //         Scaffold.of(context).openDrawer();
        //       },
        //       icon: Icon(
        //         Icons.dashboard,
        //         color: Colors.white,
        //       ),
        //     );
        //   }),
        // ),
        drawer: new MyDrawer(),
        bottomNavigationBar: BottomNavigationBar(
          // showSelectedLabels: true, //选中才显示文字
          // type: BottomNavigationBarType.shifting,
          showUnselectedLabels: true,
          unselectedItemColor: Color.fromRGBO(100, 102, 102, 1.0),
          backgroundColor: Colors.blue,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "微信"),
            BottomNavigationBarItem(icon: Icon(Icons.mail), label: "通信录"),
            BottomNavigationBarItem(
                icon: Icon(Icons.adjust_sharp), label: "发现"),
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
        body:
            // SafeArea(
            //   child: PageView.builder(
            //       //要点1
            //       physics: NeverScrollableScrollPhysics(),
            //       //禁止页面左右滑动切换
            //       controller: PageController(),
            //       onPageChanged: _pageChanged,
            //       //回调函数
            //       itemCount: list.length,
            //       itemBuilder: (context, index) => list[_selectedIndex]),
            // )
            FutureBuilder(
          builder: _buildFuture,
          future: _futureBuilderFuture,
        )
        // ProgressDialog(
        //     loading: _loading, msg: '加载中', child: list[_selectedIndex]),
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

  void _pageChanged(int index) {
    print('页面改变，当前：' + index.toString());
    setState(() {
      if (_selectedIndex != index) {
        _selectedIndex = index;
      }
    });
  }

  ///snapshot就是_calculation在时间轴上执行过程的状态快照
  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        print('还没有开始网络请求');
        return Text('还没有开始网络请求');
      case ConnectionState.active:
        print('active');
        return Text('ConnectionState.active');
      case ConnectionState.waiting:
        print('waiting');
        return Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.done:
        print('done');
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        return _createListView(context, snapshot);
      default:
        return Text("");
    }
  }

  Widget _createListView(context, snapshot) {
    return IndexedStack(
      index: _selectedIndex,
      children: list,
    );
  }

  /// 初始化数据
  initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userinfo = prefs.getString("loginUserInfo");
    var userJson = json.decode(userinfo!);
    userInfo = User.fromJson(userJson);
    //初始化聊天监听
    WebSocketUtility.openSocket();
    WebSocketUtility.sendMessage({"userId": userInfo.id});
    //初始全局监听
    EventBusUtils.initEvenBus();
    Get.put(Controller());
    List<Friend> list = Controller.to.getFriendList();
  }
}
