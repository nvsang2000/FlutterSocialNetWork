import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/item/tittle/tittle.dart';
import 'package:test/models/user.dart';
import 'package:test/provider/friend_provider.dart';
import 'package:test/provider/post_provider.dart';
import 'package:test/provider/user_provider.dart';

import 'package:test/screens/profile_widget/friend/profile_friend_page.dart';

class UserItem extends StatefulWidget {
  const UserItem(
      {Key? key,
      required this.id,
      required this.token,
      required this.username,
      required this.image})
      : super(key: key);
  final String id;
  final String username;
  final String image;
  final String token;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    // FriendProvider provider = context.watch<FriendProvider>();
    // provider.getUser(widget.token, widget.id);
    // UserFriend? userFriend = provider.friendInfo;
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          FriendProvider friend = context.read<FriendProvider>();
          friend.clearUser;
          PostProvider postProvider =
              Provider.of<PostProvider>(context, listen: false);
          postProvider.clearListPost;
          return ProfileFriendPage(
            userID: widget.id,
            token: widget.token,
            listFollow: user.following!,
          );
        }),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        height: 50,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                widget.image,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) =>
                    loadingProgress == null
                        ? child
                        : Container(
                            height: 50,
                            width: 50,
                            child: Center(
                              child: CircularProgressIndicator(),
                            )),
                errorBuilder: (context, url, StackTrace? error) {
                  return Container(
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
                  );
                },
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Tittle(text: widget.username, size: 18, color: Colors.black)
          ],
        ),
      ),
    );
  }
}
