import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var _headPath;

  final ImagePicker _picker = ImagePicker();
  bool _isChecked = true;
  IconData _checkIcon = Icons.check_box;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.close),
      ),
      //键盘覆盖在容器上面
      // resizeToAvoidBottomInset: false,
      extendBody: true,
      // appBar: AppBar(),
      body: ListView(
        children: [
          SizedBox(
            height: size.height,
            width: double.maxFinite,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      "手机号注册",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      child: _headPath == null
                          ? Icon(
                              Icons.image,
                              size: 70,
                            )
                          : Image.file(
                              _headPath,
                              width: 70,
                              height: 70,
                            ),
                      onTap: () async {
                        var image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        setState(() {
                          _headPath = File(image!.path);
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: SizedBox(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
                            child: new TextFormField(
                              maxLines: 1,
                              keyboardType: TextInputType.emailAddress,
                              autofocus: false,
                              style: TextStyle(fontSize: 15),
                              decoration: new InputDecoration(
                                // border: InputBorder.none,
                                hintText: "例如：陈晨",
                                icon: Icon(
                                  Icons.person_outline,
                                ),
                                label: Text("昵称"),
                              ),
                              onSaved: (value) => {},
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
                            child: new TextFormField(
                              maxLines: 1,
                              keyboardType: TextInputType.emailAddress,
                              autofocus: false,
                              style: TextStyle(fontSize: 15),
                              initialValue: "中国大陆（+86）",
                              readOnly: true,
                              decoration: new InputDecoration(
                                icon: Icon(
                                  Icons.account_balance,
                                ),
                                label: Text("国家/地区"),
                              ),
                              onSaved: (value) => {},
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
                            child: new TextFormField(
                              maxLines: 1,
                              keyboardType: TextInputType.phone,
                              autofocus: false,
                              style: TextStyle(fontSize: 15),
                              decoration: new InputDecoration(
                                // border: InputBorder.none,
                                hintText: "请填写手机号",
                                icon: Icon(
                                  Icons.phone,
                                ),
                                prefixText: "+86 ",
                                label: Text("手机号"),
                              ),
                              onSaved: (value) => {},
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
                            child: new TextFormField(
                              obscureText: true,
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              autofocus: false,
                              style: TextStyle(fontSize: 15),
                              decoration: new InputDecoration(
                                // border: InputBorder.none,
                                icon: Icon(
                                  Icons.password_sharp,
                                ),
                                label: Text("密码"),
                              ),
                              onSaved: (value) => {},
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
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
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(bottom: 40),
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      "注册",
                      style: TextStyle(color: Colors.black54),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
