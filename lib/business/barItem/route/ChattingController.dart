import 'dart:async';

import 'package:chat_app/common/database/DBManage.dart';
import 'package:chat_app/common/event/EventBusUtil.dart';
import 'package:chat_app/common/network/WebSocketManage.dart';
import 'package:chat_app/common/network/impl/ApiImpl.dart';
import 'package:chat_app/common/utils/Utils.dart';
import 'package:chat_app/models/friend.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import '../other/ReceivedMessageScreen.dart';
import '../other/SendMessageScreen.dart';

final ThemeData kIOSTheme = ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
      .copyWith(secondary: Colors.blue[400]),
);

late List<Message> _messages = [];
final ApiImpl request = new ApiImpl();
User userInfo = new User();
Friend friendInfo = new Friend();

///接收传递的参数
///0：聊天记录
///1：朋友信息
///2：用户信息
late List arguments = [];

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isComposing = false;
  bool _buttonShow = false;

  double _cardSize = 50;
  double _cardHeight = 60;
  double _cardWidth = 60;
  Color _cardColor = Colors.white60;
  double _cardBorderRadius = 10;

  bool _loading = false;

  late StreamSubscription eventBus;

  ScrollController _customController =
      ScrollController(initialScrollOffset: 100);

  @protected
  void initState() {
    print('聊天界面初始化');

    ///滚动条位置监听
    _customController.addListener(() {
      ///当位置到0的时候开始追加新的聊天消息
      if (_customController.offset ==
          _customController.position.maxScrollExtent) {
        addMessage();
      }
      setState(() {
        _loading = false;
      });
    });

    /// 全局添加接收消息监听
    eventBus =
        EventBusUtils.getInstance().on<WebSocketUtility>().listen((event) {
      print('监听到的数据:' + event.receiveMsg.toString());
      if (event.receiveMsg.userId == friendInfo.friendId) {
        if (mounted) {
          //更新全部消息为已读
          DBManage.updateUnReadMessage(friendInfo.friendId);
          setState(() {
            _messages.add(event.receiveMsg);
          });
          scrollMsgBottom();
        }
      }
    });

    //通过获取键盘的显示，来控制加号的显示
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        if (visible) {
          _buttonShow = false;
        }
      },
    );
    arguments = Get.arguments;
    //初始化聊天信息
    _messages = arguments[0];
    //初始化朋友信息
    friendInfo = arguments[1];
    userInfo = arguments[2];

    ///初始化聊天信息
    scrollMsgBottom();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(friendInfo.friendNickname),
      ),
      body: Container(
        decoration: Theme.of(context).platform == TargetPlatform.iOS //new
            ? BoxDecoration(
                border: Border(
                top: BorderSide(color: Colors.grey[200]!),
              ))
            : null,
        child: Column(
          children: [
            Flexible(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    this._buttonShow = false;
                    this._focusNode.unfocus();
                  });
                },

                ///聊天列表
                child:
                    // RefreshIndicator(
                    //   onRefresh: _refresh,
                    //   child:
                    CustomScrollView(
                  reverse: true,
                  controller: _customController,
                  slivers: <Widget>[
                    SliverFixedExtentList(
                      delegate: SliverChildBuilderDelegate(_cellForRow,
                          childCount: _messages.length),
                      itemExtent: 80,
                    ),
                    SliverToBoxAdapter(
                      child: Offstage(
                        offstage: _loading,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    )
                  ],
                ),
                // ),
              ),
            ),
            const Divider(height: 0),
            Container(
              // height: 70.0,
              width: double.maxFinite,
              color: Color.fromRGBO(223, 224, 225, 1.0),
              // decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
            //扩展功能
            Visibility(
              maintainAnimation: true,
              child: Container(
                height: size.height / 4,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    color: Color.fromRGBO(223, 224, 225, 1.0)),
                child: Container(
                  margin: EdgeInsets.only(left: 10, top: 20, right: 10),
                  child: new Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        _cardBorderRadius),
                                    color: _cardColor,
                                  ),
                                  height: _cardHeight,
                                  width: _cardWidth,
                                  // color: _cardColor,
                                  child: Container(
                                      child: IconButton(
                                    icon: Icon(Icons.photo_library),
                                    onPressed: () {},
                                  )),
                                ),
                                Container(
                                  height: _cardHeight,
                                  width: _cardWidth,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        _cardBorderRadius),
                                    color: _cardColor,
                                  ),
                                  child: Icon(
                                    Icons.photo_camera,
                                    size: _cardSize,
                                  ),
                                ),
                                Container(
                                  height: _cardHeight,
                                  width: _cardWidth,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        _cardBorderRadius),
                                    color: _cardColor,
                                  ),
                                  child: Icon(
                                    Icons.settings_phone,
                                    size: _cardSize,
                                  ),
                                ),
                                Container(
                                  height: _cardHeight,
                                  width: _cardWidth,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        _cardBorderRadius),
                                    color: _cardColor,
                                  ),
                                  child: Icon(
                                    Icons.pin_drop,
                                    size: _cardSize,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: _cardHeight,
                                  width: _cardWidth,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        _cardBorderRadius),
                                    color: _cardColor,
                                  ),
                                  child: Icon(
                                    Icons.payments,
                                    size: _cardSize,
                                  ),
                                ),
                                Container(
                                  height: _cardHeight,
                                  width: _cardWidth,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        _cardBorderRadius),
                                    color: _cardColor,
                                  ),
                                  child: Icon(
                                    Icons.image,
                                    size: _cardSize,
                                  ),
                                ),
                                Container(
                                  height: _cardHeight,
                                  width: _cardWidth,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        _cardBorderRadius),
                                    color: _cardColor,
                                  ),
                                  child: Icon(
                                    Icons.image,
                                    size: _cardSize,
                                  ),
                                ),
                                Container(
                                  height: _cardHeight,
                                  width: _cardWidth,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        _cardBorderRadius),
                                    color: _cardColor,
                                  ),
                                  child: Icon(
                                    Icons.image,
                                    size: _cardSize,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: 2, //轮播页数
                    pagination: SwiperPagination(), //底部小圆点
                    // control: SwiperControl(),//左右按钮
                    viewportFraction: 1, //小于1时可以预览下一页和上一页
                    scale: 0.9,
                  ),
                ),
              ),
              maintainState: true,
              visible: _buttonShow,
            ),
          ],
        ),
      ),
    );
  }

//默认功能：表情、输入框、发送、扩展
  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //语音按钮
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(left: 5, right: 10),
                      child: Icon(
                        Icons.mic,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                //聊天输入框
                Flexible(
                  flex: 7,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 3),
                    height: 35,
                    color: Colors.white,
                    child: TextField(
                      cursorHeight: 35,
                      textAlign: TextAlign.start,
                      maxLines: 10,
                      controller: _textController,
                      textInputAction: TextInputAction.send,
                      onChanged: (text) {
                        setState(() {
                          /// todo 当输入内容时就会发送数据，需要优化
                          _isComposing = text.isNotEmpty;
                        });
                      },
                      onSubmitted: _isComposing ? _handleSubmitted : null,
                      decoration: const InputDecoration.collapsed(hintText: ''),
                      focusNode: _focusNode,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    // margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    // Theme.of(context).platform == TargetPlatform.iOS
                    child: IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.black,
                      ),
                      onPressed: _isComposing
                          ? () => _handleSubmitted(_textController.text)
                          : null,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: extendFunction,
                    child: Icon(
                      Icons.add_circle_outline,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) async {
    _textController.clear();
    Message newMessage = new Message();

    /// todo 需要解决id为毫秒时间戳，存在重复问题，但用到了id自增特性，需要解决
    /// 为保证本地数据库中消息ID与服务器ID相同，在本地创建
    newMessage.id = Utils.getIncreaseNum();
    newMessage.friendId = friendInfo.friendId;
    newMessage.friendNickname = friendInfo.friendNickname;
    newMessage.context = text;
    newMessage.createTime = DateTime.now().toString();
    newMessage.userId = userInfo.id;
    newMessage.headImgUrl = userInfo.headImgUrl;
    newMessage.haveRead = 1;
    newMessage.type = 1;
    newMessage.url = '';
    newMessage.state = 0;
    //发送消息
    request
        .sendMessage(friendInfo.friendId.toString(), newMessage)
        .catchError((onError) {
      ///todo 发送失败本地处理
      newMessage.state = 1;
      print('当前错误：' + onError.toString());
    });
    DBManage.updateSendMessage(newMessage);

    setState(() {
      _isComposing = false;
      _messages.insert(0, newMessage);
    });
    _focusNode.requestFocus();
    // message.animationController.forward();
    //每次发送跳到最下面
    scrollMsgBottom();
  }

  //展开加号按钮
  void extendFunction() {
    _focusNode.unfocus();
    setState(() {
      _buttonShow = true;
    });
  }

  Widget _cellForRow(BuildContext context, int index) {
    Message message = _messages[index];
    var msg;
    if (message.userId == userInfo.id) {
      msg = SentMessageScreen(
        message: message,
      );
    } else {
      msg = ReceivedMessageScreen(
        message: message,
      );
    }
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: msg,
    );
  }

  //聊天列表跳的最下面
  void scrollMsgBottom() {
    Timer(
        Duration(milliseconds: 100),
        () => _customController
            .jumpTo(_customController.position.minScrollExtent));
  }

  Future addMessage() async {
    num messageId = _messages[_messages.length - 1].id;
    print("消息id:$messageId");
    var messages = await DBManage.getNextMessages(
        friendInfo.friendId.toString(), messageId);
    setState(() {
      _loading = true;
      _messages.addAll(messages);
    });
  }

  @override
  void dispose() {
    super.dispose();
    print('聊天界面卸载了');
    // _messages.clear();
    // eventBus.cancel();
  }
}
