import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/item/tittle/tittle.dart';
import 'package:test/screens/BarItem/profile_page.dart';
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
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) =>
                ProfileFriendPage(userID: widget.id, token: widget.token)),
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
