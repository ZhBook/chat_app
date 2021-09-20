import 'package:chat_app/page/HomeScreen.dart';
import 'package:chat_app/page/MailScreen.dart';
import 'package:chat_app/page/PersonScreen.dart';
import 'package:chat_app/page/ToolsScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatApp',
      theme: ThemeData(
        splashColor: Colors.transparent, //去掉水波纹效果
      ),
      home: ScaffoldRoute(),
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

  int _selectedIndex = 1;

  late TabController _tabController; //需要定义一个Controller

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; //
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
        title: Text("AppChat"),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.share))
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
          BottomNavigationBarItem(
            icon: Icon(Icons.find_in_page_outlined),
            label: "发现",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "我"),
        ],
        currentIndex: _selectedIndex, //items的index
        fixedColor: Colors.blue,
        onTap: _onItemTapped, //底部菜单点击事件
      ),
      floatingActionButton: FloatingActionButton(
        //悬浮按钮
        child: Icon(Icons.add),
        onPressed: _onAdd,
      ),
      body: list[_selectedIndex],
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 38.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ClipOval(
                          child: Text("图片"),
                        ),
                      ),
                      Text(
                        "Wendux",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text("Add account"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text("Manage Accounts"),
                    )
                  ],
                ))
              ],
            )),
      ),
    );
  }
}
