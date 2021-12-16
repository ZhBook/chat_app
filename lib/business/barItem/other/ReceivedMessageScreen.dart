import 'dart:math' as math; // import this

import 'package:chat_app/business/barItem/route/PersonInfoController.dart';
import 'package:chat_app/common/Controller.dart';
import 'package:chat_app/models/index.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CustomShape.dart';

User userInfo = new User();

class ReceivedMessageScreen extends StatelessWidget {
  final Message message;
  const ReceivedMessageScreen({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    Friend friend =
        Controller.to.getFriendInfo(message.friendId, message.userId);
    return Flexible(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: CustomPaint(
            painter: CustomShape(Colors.grey.shade300),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(PersonInfoPage(
              userInfo: friend,
            ));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.network(
              message.headImgUrl,
              fit: BoxFit.cover,
              width: 40,
              height: 40,
            ),
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: Text(
              message.context,
              overflow: TextOverflow.visible,
              maxLines: 10,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
