import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Chating extends StatelessWidget {
  const Chating({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var index = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("data$index"),
      ),
      body: Container(
        child: Text("data$index"),
      ),
    );
  }
}
