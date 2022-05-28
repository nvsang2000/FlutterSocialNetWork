import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/api/api_url.dart';
import 'package:test/models/friend.dart';
import 'package:test/models/user.dart';
import 'package:test/provider/edit_infor_provider.dart';
import 'package:test/provider/friend_provider.dart';
import 'package:test/provider/post_provider.dart';
import 'package:test/provider/user_provider.dart';

class CoverImageFriendWidget extends StatefulWidget {
  const CoverImageFriendWidget({
    Key? key,
    required this.token,
    required this.iduser,
    required this.coverHeight,
    required this.urlImage,
  }) : super(key: key);
  final String urlImage;
  final double coverHeight;
  final String token;
  final String iduser;
  @override
  State<CoverImageFriendWidget> createState() => _CoverImageFriendWidgetState();
}

class _CoverImageFriendWidgetState extends State<CoverImageFriendWidget> {
  bool isFriend = false;
  bool _isFriend = false;
  bool isLoad = false;
  String? _iduser;
  User? _user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getId();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider user = Provider.of<UserProvider>(context);
    if (_iduser != null) {
      user.getUser(widget.token, _iduser!);
      _user = user.friendInfo;
    }

    checkFollow();
    return Stack(
      children: [
        Container(
          alignment: Alignment.topRight,
          height: widget.coverHeight,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            child: Image.network(
              widget.urlImage,
              height: widget.coverHeight,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingProgress == null
                      ? child
                      : Container(
                          height: widget.coverHeight,
                          width: double.infinity,
                          child: Center(
                            child: CircularProgressIndicator(),
                          )),
              errorBuilder: (context, url, StackTrace? error) {
                return Image.asset(
                  "images/background.png",
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
        button()
      ],
    );
  }

  Future<void> getId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? id = pref.getString('_id');
    setState(() {
      _iduser = id;
    });
  }

  Future<bool> checkFollow() async {
    if (_user != null) {
      for (String i in _user!.following!) {
        if (i == widget.iduser) {
          setState(() {
            isFriend = true;
          });
        } else {
          setState(() {
            isFriend = false;
          });
        }
        setState(() {
          _isFriend = isFriend;
          isLoad = true;
        });
      }
    }

    return isFriend;
  }

  Future<void> follow(String token, String id, bool _isFollow) async {
    var url;
   
    if (_isFollow)
      url = ApiUrl.unfollowUrl;
    else
      url = ApiUrl.followUrl;
    print(DateTime.now());
    Response response = await post(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ' + token,
          'Content-Type': 'application/json'
        },
        body: json.encode({'userId': id}));
    if (response.statusCode == 200) {
      print(DateTime.now());
    } else
      throw Exception('Failed to load.');
  }

  Container button() {
    return Container(
      padding: EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
            isLoad
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: _isFriend ? Colors.red : Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () {
                      setState(() {
                        _isFriend = !_isFriend;
                      });
                      follow(widget.token, widget.iduser, !_isFriend);
                    },
                    child: tittleButton(),
                  )
                : CircularProgressIndicator()
          ]),
    );
  }

  Row tittleButton() => Row(
        children: [
          Icon(
            _isFriend ? Icons.person_remove : Icons.person_add,
            color: _isFriend ? Colors.black : null,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            _isFriend ? "Unfollow" : "Follow",
            style: TextStyle(
                color: _isFriend ? Colors.black : null,
                fontWeight: FontWeight.bold),
          )
        ],
      );
}
