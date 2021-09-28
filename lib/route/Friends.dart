import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Friends extends StatelessWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("朋友圈"),
        centerTitle: true,
      ),
      body: _Friends(),
    );
  }
}

class _Friends extends StatefulWidget {
  const _Friends({Key? key}) : super(key: key);

  @override
  _FriendsStateState createState() => _FriendsStateState();
}

class _FriendsStateState extends State<_Friends> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                    height: size.height * 2 / 5,
                    width: double.maxFinite,
                    // color: Colors.greenAccent,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: size.height * 1 / 3,
                          child: Image.asset("assets/images/background.jpg",
                              fit: BoxFit.fill),
                        ),
                        Positioned(
                          bottom: 40,
                          right: 10,
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Text(
                                      "小鹿儿心头撞",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    )),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    "assets/images/1.jpeg",
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              );
            }
            return GestureDetector(
              onTap: () {},
              child: Container(
                  child: Container(
                // color: Colors.amberAccent,
                width: double.maxFinite,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[200]!),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: Icon(
                              Icons.people_alt_rounded,
                              size: 50,
                            ),
                          )),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(child: Text("朋友")),
                            index % 2 == 0
                                ? Image.asset("assets/images/background.jpg",
                                    width: 200, height: 200, fit: BoxFit.fill)
                                : Container(
                                    child: Text(
                                        "在艰苦中成长成功之人，往往由于心理的阴影，会导致变态的偏差。这种偏差，便是对社会、对人们始终有一种仇视的敌意，不相信任何一个人，更不同情任何一个人。爱钱如命的悭吝，还是心理变态上的次要现象。相反的，有器度、有见识的人，他虽然从艰苦困难中成长，反而更具有同情心和慷慨好义的胸襟怀抱。因为他懂得人生，知道世情的甘苦。——南怀瑾"),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            );
          },
          itemCount: 10,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.white30,
              height: 0.5,
            );
          },
        ),
      ),
    );
  }
}
