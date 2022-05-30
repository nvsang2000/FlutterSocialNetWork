// ignore_for_file: unused_field

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:test/api/api_url.dart';
import 'package:test/models/user.dart';
import 'package:test/provider/edit_infor_provider.dart';
import 'package:test/provider/friend_provider.dart';
import 'package:test/provider/user_provider.dart';

class FollowButton extends StatefulWidget {
  const FollowButton(
      {Key? key,
      required this.token,
      required this.iduser,
      required this.listFollow})
      : super(key: key);
  final String token;
  final String iduser;
  final List<String> listFollow;
  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  late bool isFriend;
  bool isLoad = true;
  bool? _isFriend;
  User? _user;
  @override
  void initState() {
    super.initState();
    checkFollow();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider user = Provider.of<UserProvider>(context);
    var users = Provider.of<UserProvider>(context).user;
    EditInforProvider edit = Provider.of<EditInforProvider>(context);
    return Container(
      padding: EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  FriendProvider friend = context.read<FriendProvider>();
                  friend.clearUser;
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
            isLoad
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: isFriend ? Colors.red : Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () async {
                      setState(() {
                        isFriend = !isFriend;
                      });
                      await follow(widget.token, widget.iduser, !isFriend);
                      User _user =
                          await edit.getUser(widget.token, users.iduser!);
                      user.setUser(_user);
                      edit.notify();
                      print(users.following);
                    },
                    child: Row(
                      children: [
                        Icon(
                          isFriend ? Icons.person_remove : Icons.person_add,
                          color: isFriend ? Colors.black : null,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          isFriend ? "Unfollow" : "Follow",
                          style: TextStyle(
                              color: isFriend ? Colors.black : null,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                : CircularProgressIndicator()
          ]),
    );
  }

  Future<void> follow(String token, String id, bool _isFollow) async {
    var url;
    if (_isFollow)
      url = ApiUrl.unfollowUrl;
    else
      url = ApiUrl.followUrl;

    Response response = await post(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ' + token,
          'Content-Type': 'application/json'
        },
        body: json.encode({'userId': id}));
    if (response.statusCode == 200) {
    } else
      throw Exception('Failed to load.');
  }

  Future<void> checkFollow() async {
    _isFriend = false;
    if (widget.listFollow.length >= 1) {
      for (String i in widget.listFollow) {
        if (widget.iduser == i) {
          _isFriend = true;
          break;
        }
      }
    }
    setState(() {
      isFriend = _isFriend!;
    });
  }
}
