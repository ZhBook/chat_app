import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/common/database/DBManage.dart';
import 'package:chat_app/common/network/Api.dart';
import 'package:chat_app/common/network/impl/ApiImpl.dart';
import 'package:chat_app/common/utils/UserInfoUtils.dart';
import 'package:chat_app/models/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Friends extends StatelessWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Friends(),
    );
  }
}

//朋友圈信息
List list = [];
Api api = new ApiImpl();
ScrollController _scrollController = new ScrollController();
num pageIndex = 1;
User user = new User();
bool _visible = false;
double opacityLevel = 0;

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // backgroundColor: Colors.white60,
        title: Text(
          "朋友圈",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _visible = !_visible;
                if (opacityLevel == 1.0) {
                  opacityLevel = 0;
                } else {
                  opacityLevel = 1.0;
                }
              });
            },
            icon: Icon(
              Icons.photo_camera,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // SliverAppBar(
              //   pinned: true,
              //   stretch: true,
              //   flexibleSpace: FlexibleSpaceBar(
              //     title: Text("朋友圈"),
              //   ),
              //   backgroundColor: Colors.transparent,
              // ),
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 300,
                    width: double.maxFinite,
                    // color: Colors.greenAccent,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: 260,
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://tensua-file.oss-cn-hangzhou.aliyuncs.com/files/4e4ac3c268b8465780b9cc91fb15bc36.jpg",
                            fit: BoxFit.fill,
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Positioned(
                          bottom: 30,
                          right: 10,
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    user.nickname,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: user.headImgUrl,
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  _cellForRow,
                  childCount: list.length,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  "我也是有底线的",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black45,
                    height: 3,
                  ),
                ),
              ),
            ],
          ),
          // Visibility(
          //   visible: _visible,
          //   child:
          AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: opacityLevel,
            curve: Curves.linear,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _visible = false;
                });
              },
              child: Container(
                color: Color.fromRGBO(157, 153, 153, 0.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                        ),
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        height: 45,
                        child: Text("发布"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        height: 45,
                        child: Text("拍摄"),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(width: 0.1),
                            bottom: BorderSide(width: 0.1),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        height: 45,
                        child: Text("从手机相册选取"),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(width: 0.1),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _visible = false;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        height: 40,
                        color: Colors.white,
                        child: Text("取消"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // ),
        ],
      ),
    );
  }

  Widget _cellForRow(BuildContext context, int index) {
    Moments moments = list[index];
    Friend userInfo = new Friend();
    if (user.id == moments.userId) {
      userInfo.headImgUrl = user.headImgUrl;
      userInfo.nickname = user.nickname;
    } else {
      DBManage.getFriend(user.id, moments.userId).then((value) {
        setState(() {
          userInfo = value;
        });
      });
    }

    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: CachedNetworkImage(
                  imageUrl: userInfo.headImgUrl,
                  width: 60,
                  height: 60,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              )),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userInfo.nickname),
                Text(moments.context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    pageIndex = 1;
    super.initState();
    init();
  }

  void init() async {
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        getMomentInfo();
      }
    });
    var result = await api.getMoments(pageIndex, 10);
    List<Moments> resultList = [];
    if (result.code == 200) {
      resultList = result.data.map((element) {
        return Moments.fromJson(element);
      }).toList();
    }
    var userInfo = await UserInfoUtils.getUserInfo();
    if (mounted) {
      setState(() {
        list = resultList;
        user = userInfo;
        _visible = false;
      });
    }
  }

  ///todo 优化数据加载
  getMomentInfo() async {
    var result = await api.getMoments(pageIndex + 1, 10);
    List<Moments> resultList = [];
    if (result.code == 200 && result.data.length > 0) {
      pageIndex = result.pageIndex;
      resultList = result.data.map((element) {
        return Moments.fromJson(element);
      }).toList();
      if (mounted) {
        setState(() {
          list.addAll(resultList);
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
