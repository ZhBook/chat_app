import 'package:chat_app/business/login/route/RegisterController.dart';
import 'package:chat_app/common/network/impl/ApiImpl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../barItem/controller/BarItemController.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();
  final ApiImpl request = new ApiImpl();

  String username = "123";
  String password = "123";
  bool _isChecked = true;
  bool _isLoading = true;
  IconData _checkIcon = Icons.check_box;

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        initialValue: "123",
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        style: TextStyle(fontSize: 15),
        decoration: new InputDecoration(
            border: InputBorder.none,
            hintText: "请输入账户",
            icon: Icon(
              Icons.email,
              color: Colors.grey,
            )),
        onSaved: (value) => username = value!,
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
      child: TextFormField(
        initialValue: "123",
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        style: TextStyle(fontSize: 15),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "请输入密码",
            icon: Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        onSaved: (value) => password = value!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.white,
        middle: Text("登陆"),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30),
            height: 220,
            child: Image(
              image: AssetImage("assets/images/logo.webp"),
            ),
          ),
          Form(
            key: _formKey,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.fromLTRB(25, 0, 25, 0.0),
              child: Card(
                child: Column(
                  children: [
                    _showEmailInput(),
                    Divider(
                      height: 0.5,
                      indent: 16.0,
                      color: Colors.grey[300],
                    ),
                    _showPasswordInput(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 70,
            padding: EdgeInsets.fromLTRB(35, 30, 35, 0),
            child: OutlinedButton(
              child: Text(
                "登陆",
                style: TextStyle(color: Colors.orange),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                _onLogin();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(40, 10, 50, 0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isChecked = !_isChecked;
                      if (_isChecked) {
                        _checkIcon = Icons.check_box;
                      } else {
                        _checkIcon = Icons.check_box_outline_blank;
                      }
                    });
                  },
                  icon: Icon(_checkIcon),
                  color: Colors.orange,
                ),
                Expanded(
                    child: RichText(
                  text: TextSpan(
                      text: "我已详细阅读并同意",
                      style: TextStyle(color: Colors.black, fontSize: 13),
                      children: [
                        TextSpan(
                            text: "《隐私政策》",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline)),
                        TextSpan(text: "和"),
                        TextSpan(
                            text: "《用户协议》",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline))
                      ]),
                ))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 35),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      "找回密码",
                      style: TextStyle(color: Colors.black54),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                ),
                OutlinedButton(
                    onPressed: () {
                      Get.to(Register());
                    },
                    child: Text(
                      "注册账号",
                      style: TextStyle(color: Colors.black54),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _changeFormToLogin() {
    _formKey.currentState!.reset();
  }

  /// 点击登陆按钮进行逻辑处理
  Future<void> _onLogin() async {
    final form = _formKey.currentState;
    form!.save();
    if (username == '') {
      _showMessageDialog("账户不能为空");
      return;
    }
    if (password == '') {
      _showMessageDialog("密码不能为空");
      return;
    }
    request.login(username, password).then((value) {
      print(value.toJson());
      if (value.code == 200) {
        // Navigator.of(context).pushNamed("home");

        Fluttertoast.showToast(msg: "登陆成功");

        Get.to(ScaffoldRoute());
        return;
      } else {
        _showMessageDialog("用户名或密码错误");
        return;
      }
    }).catchError((onError) {
      _showMessageDialog("服务器异常");
    });
  }

  void _showMessageDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text('提示'),
          content: new Text(message),
          actions: <Widget>[
            new ElevatedButton(
              child: new Text("ok"),
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
