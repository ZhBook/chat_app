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
    return Flexible(
        child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // margin: EdgeInsets.all(5),
          margin: EdgeInsets.fromLTRB(50.0, 10.0, 10.0, 10.0),
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          decoration: BoxDecoration(
            color: Colors.cyan[900],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18),
            ),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 200.0,
            ),
            child: Text(
              message.context,
              // overflow: TextOverflow.visible,
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
  }
}
