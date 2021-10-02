import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();

  String _userID = "admin";
  String _password = "123456";
  bool _isChecked = true;
  bool _isLoading = true;
  IconData _checkIcon = Icons.check_box;

  void _changeFormToLogin() {
    _formKey.currentState!.reset();
  }

  void _onLogin() {
    final form = _formKey.currentState;
    form!.save();
    if (_userID == '') {
      _showMessageDialog("账户不能为空");
      return;
    }
    if (_password == '') {
      _showMessageDialog("账户不能为空");
      return;
    }
    if (_userID == "admin" && _password == "123456") {
      _showMessageDialog("登陆成功");
      Navigator.of(context).pushNamed("home");
      return;
    } else {
      _showMessageDialog("密码错误");
      return;
    }
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

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        initialValue: "admin",
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
        onSaved: (value) => _userID = value!.trim(),
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
      child: TextFormField(
        initialValue: "123456",
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
        onSaved: (value) => _password = value!.trim(),
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
          )
        ],
      ),
    );
  }
}
