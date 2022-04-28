// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:test/item/tittle.dart';

class Stories extends StatefulWidget {
  const Stories({Key? key}) : super(key: key);

  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  Text txt = Text(
    "Xem thêm",
    style: TextStyle(fontWeight: FontWeight.bold),
  );
  bool isLike = false;
  String post =
      "Google Dịch là một công cụ dịch thuật trực tuyến do Google phát triển. Nó cung cấp giao diện trang web, ứng dụng trên thiết bị di động cho hệ điều hành Android và iOS và giao diện lập trình ứng dụng giúp nhà phát triển xây dựng tiện ích mở rộng trình duyệt web và ứng dụng phần mềm";
  late String shortText;
  late String longText;
  bool isText = true;
  int likeCount = 10;
  String time =
      DateTime.now().hour.toString() + ":" + DateTime.now().minute.toString();
  void initState() {
    super.initState();

    if (post.length > 200) {
      shortText = post.substring(0, 200);
      longText = post.substring(200, post.length);
    } else {
      shortText = post;
      longText = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10),
        //     color: Colors.white,
        //     boxShadow: [BoxShadow(color: Color(0xFF6F35A5), blurRadius: 5)]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF6F35A5),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.black, width: 1),
                        image: DecorationImage(
                            image: AssetImage('images/profile.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Tittle(text: "Văn Liệu", size: 18, color: Colors.black),
                        Text(time + " Ago")
                      ],
                    )
                  ],
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
              ],
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isText = !isText;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: RichText(
                    text: isText
                        ? TextSpan(style: ColorBlack(), children: [
                            TextSpan(text: shortText),
                            TextSpan(
                                text: "...Xem thêm",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ))
                          ])
                        : TextSpan(children: [
                            TextSpan(text: shortText),
                            TextSpan(text: longText)
                          ], style: ColorBlack())),
                // Text(isText
                //     ? shortText +
                //         TextSpan(
                //                 text: "...Xem thêm",
                //                 style: TextStyle(
                //                     fontWeight: FontWeight.bold,
                //                     fontSize: 40,
                //                     color: Colors.teal))
                //             .toPlainText()
                //     : shortText + longText),
              ),
            ),
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/story.jpg'), fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(1000),
                          topRight: Radius.circular(200),
                          bottomLeft: Radius.circular(400),
                          bottomRight: Radius.circular(400)),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            LikeButton(
                              padding: EdgeInsets.only(left: 20),
                              isLiked: isLike,
                              likeCount: likeCount,
                              likeBuilder: (isLike) {
                                final color = isLike ? Colors.red : Colors.grey;
                                final icon = isLike
                                    ? Icons.favorite
                                    : Icons.favorite_outline;
                                return Icon(
                                  icon,
                                  color: color,
                                );
                              },
                              countBuilder: (count, isLike, text) {
                                final color =
                                    isLike ? Colors.black : Colors.grey;
                                return Text(
                                  text,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: color,
                                      fontWeight: FontWeight.bold),
                                );
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.message,
                                    color: Colors.grey,
                                  ),
                                  splashColor: Colors.transparent,
                                ),
                                Text(
                                  likeCount.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.ios_share,
                              color: Colors.grey,
                            ),
                            splashColor: Colors.transparent)
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  TextStyle ColorBlack() => TextStyle(color: Colors.black, fontSize: 16);
}
