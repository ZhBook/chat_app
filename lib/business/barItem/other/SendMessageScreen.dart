import 'package:chat_app/models/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CustomShape.dart';

class SentMessageScreen extends StatelessWidget {
  final Message message;
  const SentMessageScreen({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.cyan[900],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: Text(
              message.context,
              overflow: TextOverflow.visible,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
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
        CustomPaint(painter: CustomShape(Colors.cyan.shade900)),
      ],
    ));

    return Padding(
      padding: EdgeInsets.only(right: 18.0, left: 50, top: 15, bottom: 5),
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
