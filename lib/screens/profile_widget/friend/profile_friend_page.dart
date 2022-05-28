// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/models/friend.dart';
import 'package:test/provider/friend_provider.dart';

import 'package:test/screens/profile_widget/friend/top_friend_widged.dart';
import 'package:test/screens/profile_widget/menu_widget.dart';
import 'package:test/screens/profile_widget/my_profile/information_user.dart';
import 'package:test/screens/profile_widget/profile_user/menu_2_widget.dart';

class ProfileFriendPage extends StatefulWidget {
  const ProfileFriendPage({Key? key, required this.userID, required this.token})
      : super(key: key);
  final String userID;
  final String token;
  @override
  State<ProfileFriendPage> createState() => _ProfileFriendPageState();
}

class _ProfileFriendPageState extends State<ProfileFriendPage> {
  double coverHeight = 200;
  double avartaHeight = 120;
  UserFriend? userFriend;
  @override
  Widget build(BuildContext context) {
    double menuWidth = (MediaQuery.of(context).size.width - 40);
    FriendProvider friendProvider = Provider.of<FriendProvider>(context);
    friendProvider.getUser(widget.token, widget.userID);
    userFriend = friendProvider.friendInfo;

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
        userFriend!.username,
        userFriend!.about,
        userFriend!.birthday,
        userFriend!.address,
        userFriend!.gender.toString()
      ];
    }
    return Scaffold(
        body: Container(
      child: userFriend != null
          ? ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                TopFriendWidget(
                    coverHeight: coverHeight,
                    avartaHeight: avartaHeight,
                    avatarUrl: userFriend!.avartaImage!,
                    coverUrl: userFriend!.coverImage!),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        userFriend!.username!,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        userFriend!.about!,
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
                              menu: "Post", index: 100, width: menuWidth),
                          MenuWidget(
                              menu: "Photos", index: 100, width: menuWidth),
                          MenuWidget(
                              menu: "Followers", index: 100, width: menuWidth),
                          MenuWidget(
                              menu: "Following", index: 100, width: menuWidth),
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
                              builder: (context) => Information(
                                    isBool: false,
                                  )));
                        },
                      )
                    ],
                  ),
                )
              ],
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(),
              )),
    ));
  }
}
