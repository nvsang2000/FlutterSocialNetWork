// ignore_for_file: unused_local_variable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/item/tittle/tittle.dart';
import 'package:test/models/friend.dart';
import 'package:test/models/post.dart';
import 'package:test/provider/friend_provider.dart';

import 'package:test/provider/post_provider.dart';
import 'package:test/screens/posts/post_item.dart';
import 'package:test/screens/profile_widget/friend/information_user.dart';
import 'package:test/screens/profile_widget/friend/top_friend_widged.dart';
import 'package:test/screens/profile_widget/menu_widget.dart';
import 'package:test/screens/profile_widget/profile_user/menu_2_widget.dart';

class ProfileFriendPage extends StatefulWidget {
  const ProfileFriendPage(
      {Key? key,
      // required this.userFriend,
      required this.userID,
      required this.token,
      required this.listFollow})
      : super(key: key);
  final String userID;
  final String token;
  final List<String> listFollow;
  // final UserFriend userFriend;
  @override
  State<ProfileFriendPage> createState() => _ProfileFriendPageState();
}

class _ProfileFriendPageState extends State<ProfileFriendPage> {
  double coverHeight = 200;
  double avartaHeight = 120;
  // UserFriend? userFriend;
  FriendProvider? friendProvider;
  List<Post> list = [];

  @override
  void initState() {
    super.initState();
    print(widget.userID);

    // FriendProvider friendProvider =
    //     Provider.of<FriendProvider>(context, listen: false);
    // friendProvider.clearUser;
  }

  @override
  Widget build(BuildContext context) {
    double menuWidth = (MediaQuery.of(context).size.width - 40);
    PostProvider postProvider =
        Provider.of<PostProvider>(context, listen: false);
    postProvider.getAllPostForUser(widget.userID);
    list = postProvider.getAllListForUser;
    friendProvider = Provider.of<FriendProvider>(context);
    friendProvider!.getUser(widget.token, widget.userID);
    UserFriend userFriend = Provider.of<FriendProvider>(context).userFriend;
    // userFriend = friendProvider.friendInfo;
    var icon = [
      Icons.person_pin,
      Icons.edit,
      Icons.cake,
      Icons.location_on_outlined,
      Icons.person
    ];
    var title = ["Username", "About", "Birthday", "Address", "Gender"];

    if (userFriend != null) {
      var content = [
        userFriend.username,
        userFriend.about,
        userFriend.birthday,
        userFriend.address,
        userFriend.gender.toString()
      ];
    }

    return Scaffold(
        body: ChangeNotifierProvider(
      create: (context) => PostProvider(),
      child: Container(
        child: userFriend.username != null
            ? ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  TopFriendWidget(
                      listFollow: widget.listFollow,
                      token: widget.token,
                      iduser: widget.userID,
                      coverHeight: coverHeight,
                      avartaHeight: avartaHeight,
                      avatarUrl: userFriend.avartaImage!,
                      coverUrl: userFriend.coverImage!),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          userFriend.username!,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          userFriend.about!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 150, 142, 142)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            MenuWidget(
                                menu: "Post",
                                index: list.length,
                                width: menuWidth),
                            MenuWidget(
                                menu: "Photos",
                                index: list.length + 2,
                                width: menuWidth),
                            MenuWidget(
                                menu: "Followers",
                                index: userFriend != null
                                    ? userFriend.followers!.length
                                    : 999,
                                width: menuWidth),
                            MenuWidget(
                                menu: "Following",
                                index: userFriend != null
                                    ? userFriend.following!.length
                                    : 999,
                                width: menuWidth),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Menu2Widget(
                          menuWidth: menuWidth,
                          isBool: false,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => InformationFriend(
                                      userFriend: userFriend,
                                    )));
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        list.length != 0
                            ? Align(
                                child: Tittle(
                                    text: "Posts",
                                    size: 24,
                                    color: Colors.black),
                                alignment: Alignment.topLeft,
                              )
                            : Container()
                      ],
                    ),
                  ),
                  widget.token != null && list.length != 0
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          reverse: true,
                          itemBuilder: (context, index) => Stories(
                              comment: list[index].comment,
                              id: list[index].id,
                              token: widget.token,
                              userID: list[index].userID,
                              content: list[index].content,
                              image: list[index].images,
                              type: list[index].type,
                              avatar: list[index].avatar,
                              like: list[index].like,
                              createdAt: list[index].createdAt,
                              username: list[index].username),
                          itemCount: list.length,
                        )
                      : Container(),
                ],
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CircularProgressIndicator(),
                )),
      ),
    ));
  }
}
