import 'dart:math' as math; // import this

import 'package:chat_app/models/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CustomShape.dart';

class ReceivedMessageScreen extends StatelessWidget {
  final Message message;
  const ReceivedMessageScreen({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
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
        Padding(
          padding: const EdgeInsets.only(right: 10),
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

    return Padding(
      padding: EdgeInsets.only(right: 50.0, left: 18, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 30),
          messageTextGroup,
        ],
      ),
    );
  }
}
