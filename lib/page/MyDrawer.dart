import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 38.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ClipOval(
                          child: Text("图片"),
                        ),
                      ),
                      Text(
                        "Wendux",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.add),
                          title: const Text("Add account"),
                        ),
                        ListTile(
                          leading: const Icon(Icons.settings),
                          title: const Text("Manage Accounts"),
                        )
                      ],
                    ))
              ],
            )),
      ),
    );
  }
}
