import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

final ThemeData kIOSTheme = ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
      .copyWith(secondary: Colors.blue[400]),
);

String _name = 'Your Name';
String _friendName = "Friend Name";

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //路由接收到的好友id
    var friendId = Get.arguments;
    //获取路由参数
    var args = ModalRoute.of(context)!.settings.arguments;
    _friendName = args.toString();

    /* return MaterialApp(
      title: _friendName,
       theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
      home: ChatScreen(),
    );*/
    return Scaffold(
      appBar: AppBar(
        title: Text(_friendName),
      ),
      body: ChatScreen(),
    );
  }
}

class ChatMessage extends StatelessWidget {
  const ChatMessage({required this.text, required this.animationController});

  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                  child: Center(
                child: Text(
                  _name[0],
                  style: TextStyle(fontSize: 12),
                ),
              )),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //好友昵称
                  Text(_name, style: TextStyle(fontSize: 18)),
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Text(text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final List<ChatMessage> _messages = [];
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isComposing = false;
  bool _buttonShow = false;

  double _cardSize = 50;
  double _cardHeight = 60;
  double _cardWidth = 60;
  Color _cardColor = Colors.white60;
  double _cardBorderRadius = 10;
  Color _extendButtonColor = Colors.black;

  ScrollController _customController =
      ScrollController(initialScrollOffset: 100);

  @protected
  void initState() {
    super.initState();
    //通过获取键盘的显示，来控制加号的显示
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        print(visible);
        if (visible) {
          _buttonShow = false;
          _extendButtonColor = Colors.black;
        }
      },
    );
    /*_customController.addListener(() {
      print('当前位置：${_customController.position}');
    });*/
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: Theme.of(context).platform == TargetPlatform.iOS //new
            ? BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[200]!),
                ),
              )
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
                child: CustomScrollView(
                  reverse: false,
                  controller: _customController,
                  slivers: <Widget>[
                    SliverFixedExtentList(
                      delegate: SliverChildBuilderDelegate(_cellForRow,
                          childCount: _messages.length),
                      itemExtent: 80,
                    )
                  ],
                ),
              ),
            ),
            const Divider(height: 1.0),
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
                        Icons.record_voice_over,
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
                      textAlign: TextAlign.start,
                      maxLines: 10,
                      controller: _textController,
                      onChanged: (text) {
                        setState(() {
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
                      color: this._extendButtonColor,
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

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    var message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: const Duration(milliseconds: 700),
        vsync: this,
      ),
    );

    ///TODO 处理发送的消息
    setState(() {
      _messages.add(message);
    });
    _focusNode.requestFocus();
    message.animationController.forward();
  }

  @override
  void dispose() {
    for (var message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  //展开加号按钮
  void extendFunction() {
    setState(() {
      _focusNode.unfocus();
      /*  Timer(Duration(milliseconds: 20), () {

      });*/
      _buttonShow = true;
      _extendButtonColor = Colors.blue;
    });
  }

  Widget _cellForRow(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.all(8.0),
      child: _messages[index],
    );
  }
}
