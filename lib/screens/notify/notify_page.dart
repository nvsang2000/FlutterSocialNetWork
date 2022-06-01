import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/item/appBar/app_bar.dart';
import 'package:test/screens/notify/notify_item.dart';

class NotifyPage extends StatelessWidget {
  const NotifyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Expanded(
            flex: 1,
            child: AppBarWidget(
                name: "Notifications",
                onTap: () => Navigator.pop(context),
                isBool: false),
          ),
          Expanded(
            flex: 9,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) =>
                  NotifyItem(content: "Item $index"),
            ),
          )
        ]),
      ),
    );
  }
}
