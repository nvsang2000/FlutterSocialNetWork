import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/models/user.dart';
import 'package:test/provider/user_provider.dart';
import 'package:test/screens/posts/comment_item.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            appBar(),
            commentContainer(context, user),
            bottomBar()
          ],
        ),
      ),
    ));
  }

  Container commentContainer(BuildContext context, User user) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: MediaQuery.of(context).size.height - 150,
      child: ListView(
        children: [
          CommentItem(user: user),
          CommentItem(user: user),
          CommentItem(user: user),
          CommentItem(user: user),
        ],
      ),
    );
  }

  Container appBar() {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        IconButton(
          splashColor: Colors.transparent,
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios, size: 20),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          "Post Comments",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ]),
    );
  }

  Container bottomBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 62,
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey),
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundImage: AssetImage("images/profile.jpg"),
              ),
              Container(
                width: 160,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Write a comment...", border: InputBorder.none),
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                  splashColor: Colors.transparent,
                  onPressed: () {},
                  icon: Icon(
                    Icons.attach_file,
                    color: Colors.grey,
                  )),
              IconButton(
                  splashColor: Colors.transparent,
                  onPressed: () {},
                  icon: Icon(
                    Icons.send_outlined,
                    color: Colors.grey,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
