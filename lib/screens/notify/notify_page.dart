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
              itemBuilder: (context, index) => NotifyItem(
                content: list[index].content!,
                image: list[index].image!,
                name: list[index].name!,
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class NotifyList {
  String? content;
  String? image;
  String? name;
  NotifyList({this.content, this.image, this.name});
}

List<NotifyList> list = <NotifyList>[
  NotifyList(
      content: 'liked your post',
      image:
          'https://res.cloudinary.com/drqaocsli/image/upload/v1653275810/avatar_defaul_ekmmv0.png',
      name: 'Văn Liệu'),
  NotifyList(
      content: 'commented on your post',
      image:
          'https://res.cloudinary.com/drqaocsli/image/upload/v1653275810/avatar_defaul_ekmmv0.png',
      name: 'Văn Sang'),
  NotifyList(
      content: 'commented on your post',
      image:
          'https://res.cloudinary.com/drqaocsli/image/upload/v1653275810/avatar_defaul_ekmmv0.png',
      name: 'Văn Liệu'),
  NotifyList(
      content: 'liked your post',
      image:
          'https://res.cloudinary.com/drqaocsli/image/upload/v1653275810/avatar_defaul_ekmmv0.png',
      name: 'Văn Sang'),
  NotifyList(
      content: 'commented on your post',
      image:
          'https://res.cloudinary.com/drqaocsli/image/upload/v1653275810/avatar_defaul_ekmmv0.png',
      name: 'Công Ái'),
];
