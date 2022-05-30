import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:like_button/like_button.dart';
import 'package:test/api/api_url.dart';
import 'package:test/screens/posts/comment/comment_screen.dart';

class BottomPost extends StatefulWidget {
  const BottomPost(
      {Key? key,
      required this.commnet,
      required this.token,
      required this.like,
      required this.iduser,
      required this.idpost})
      : super(key: key);
  final List<dynamic> like;
  final String iduser;
  final String idpost;
  final String token;
  final List<dynamic> commnet;
  @override
  State<BottomPost> createState() => _BottomPostState();
}

class _BottomPostState extends State<BottomPost> {
  int likeCount = 0;
  late bool isLike;
  bool? _isLike;
  @override
  void initState() {
    super.initState();

    checkLike();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            LikeButton(
              onTap: (isLiked) {
                setState(() {
                  if (isLiked)
                    likeCount--;
                  else
                    likeCount++;
                });
                return onLikeButtonTapped(isLiked);
              },
              padding: EdgeInsets.only(left: 20),
              isLiked: isLike,
              likeCount: likeCount,
              likeBuilder: (isLiked) {
                final color = isLiked ? Colors.red : Colors.grey;
                final icon = isLiked ? Icons.favorite : Icons.favorite_outline;
                return Icon(
                  icon,
                  color: color,
                );
              },
              countBuilder: (count, isLiked, text) {
                final color = isLiked ? Colors.black : Colors.grey;
                return Text(
                  '$likeCount',
                  style: TextStyle(
                      fontSize: 16, color: color, fontWeight: FontWeight.bold),
                );
              },
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () => showModalBottomSheet(
                // enableDrag: false,
                // isDismissible: false,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15))),
                context: context,
                builder: (context) => new CommentScreen(
                  id: widget.idpost,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.message,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${widget.commnet.length}',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
        IconButton(
            onPressed: () {
              onLikeButtonTapped(true);
            },
            icon: Icon(
              Icons.ios_share,
              color: Colors.grey,
            ),
            splashColor: Colors.transparent)
      ],
    );
  }

  Future<void> checkLike() async {
    _isLike = false;
    int _likeCount = widget.like.length;
    if (widget.like.length > 0) {
      for (Map i in widget.like) {
        if (i['userid'] == widget.iduser) {
          if (i['liked'] == 1) {
            _isLike = true;
          }
        }
      }
    }
    setState(() {
      likeCount = _likeCount;
      isLike = _isLike!;
    });
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    Map<String, dynamic>? body;
    setState(() {
      isLike = !isLike;
    });
    if (isLiked)
      body = {'statusLike': '0'};
    else
      body = {'statusLike': '1'};

    Response response = await put(Uri.parse(ApiUrl.likePost + widget.idpost),
        body: body, headers: {'Authorization': 'Bearer ' + widget.token});

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print(responseData['message']);

      return isLike;
    } else
      throw Exception('Failed to load.');
  }
}
