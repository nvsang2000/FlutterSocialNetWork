import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:test/api/api_url.dart';
import 'package:test/item/appBar/app_bar.dart';
import 'package:test/models/comments.dart';
import 'package:test/models/user.dart';
import 'package:test/provider/comment_provider.dart';
import 'package:test/provider/post_provider.dart';
import 'package:test/provider/user_provider.dart';
import 'package:test/screens/posts/comment/comment_item.dart';
import 'package:test/screens/posts/comment/comment_widget.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key, required this.id, required this.length})
      : super(key: key);
  final String id;
  final int length;
  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  List<Comments> listComments = [];

  bool isCmt = false;
  bool isLoad = false;
  String name = '';
  String idcmt = '';
  TextEditingController controller = TextEditingController();
  int count = 0;
  int length = 0;
  @override
  void initState() {
    // comment!.clearComment;
    length = widget.length;
    super.initState();
  }

  Future<void> getComment(String id, String token) async {
    List<Comments> newComments = [];
    Response response = await get(Uri.parse(ApiUrl.addComment + id), headers: {
      'Authorization': 'Bearer ' + token,
      'Content-Type': 'application/json'
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      for (Map i in responseData['comments']) {
        Comments comments = await Comments(
            iduser: i['userid']['_id'],
            idcomment: i['_id'],
            repComment: i['rep_comment'],
            idpost: i['postid'],
            image: i['userid']['avatar'],
            message: i['message'],
            username: i['userid']['username'],
            time: i['createdAt']);
        newComments.add(comments);
        listComments = newComments;
        // notifyListeners();
      }

      print(listComments.length);
    } else {
      print("getComment ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;

      getComment(widget.id, user.token!);
   
    int _count = 0;

    CommentProvider comment = context.watch<CommentProvider>();
    // print(widget.id);
    // print(user.token);

    double bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    for (var i in listComments) {
      setState(() {
        _count += i.repComment!.length;
      });
    }
    setState(() {
      count = _count;
    });
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.97,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              height: 10,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey),
                            ),
                            AppBarWidget(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              name:
                                  "Post Comments (${listComments.length + count})",
                              isBool: false,
                            ),
                          ],
                        )),
                    Expanded(
                      flex: 8,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: listComments.length > 0
                            ? ListView.builder(
                                itemCount: listComments.length,
                                itemBuilder: (context, index) {
                                  // if (listComments[index].repComment!.length >
                                  //     0) {
                                  //   print(listComments[index].repComment![0]
                                  //       ['message']);
                                  // }

                                  return CommentItem(
                                    lengthrep: count,
                                    length: listComments.length,
                                    comments: listComments[index],
                                    onTap: () {
                                      setState(() {
                                        isCmt = true;
                                        idcmt = listComments[index].idcomment!;
                                        name = listComments[index].username!;
                                      });
                                    },
                                  );
                                })
                            : Container(),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    )
                  ],
                ),
                Positioned(
                    bottom: bottomInsets,
                    child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isCmt
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Row(
                                    children: [
                                      RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                              children: [
                                            TextSpan(text: 'Reply to '),
                                            TextSpan(
                                                text: name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            TextSpan(
                                              text: "'s comment",
                                            )
                                          ])),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isCmt = false;
                                          });
                                        },
                                        child: Icon(Icons.cancel_outlined),
                                      )
                                    ],
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 60,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(width: 2, color: Colors.grey),
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
                                      backgroundImage:
                                          NetworkImage(user.avatarImage!),
                                    ),
                                    Container(
                                      width: 160,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: TextFormField(
                                        controller: controller,
                                        decoration: InputDecoration(
                                            hintText: "Write a comment...",
                                            border: InputBorder.none),
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
                                        onPressed: () async {
                                          if (controller.text.isNotEmpty) {
                                            setState(() {
                                              isLoad = true;
                                            });
                                            isCmt
                                                ? await comment.repCmt(
                                                    idcmt,
                                                    user.token!,
                                                    controller.text)
                                                : await comment.addComment(
                                                    widget.id,
                                                    user.token!,
                                                    controller.text);
                                            controller.clear();
                                            setState(() {
                                              length = 1;
                                              isCmt = false;
                                              isLoad = false;
                                            });
                                          }
                                        },
                                        icon: isLoad
                                            ? Icon(
                                                Icons.send_outlined,
                                                color: Colors.blue,
                                              )
                                            : Icon(
                                                Icons.send_outlined,
                                                color: Colors.grey,
                                              ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
