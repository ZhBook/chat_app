import 'package:flutter/widgets.dart';

class UnknownRoute extends StatefulWidget {
  const UnknownRoute({Key? key}) : super(key: key);

  @override
  _UnknownRouteState createState() => _UnknownRouteState();
}

class _UnknownRouteState extends State<UnknownRoute> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("该区域还未开发！！！")),
    );
  }
}
