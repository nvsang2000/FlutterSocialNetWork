import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/item/tittle/tittle.dart';
import 'package:test/screens/profile_widget/friend/profile_friend_page.dart';

class ItemUser extends StatefulWidget {
  const ItemUser({Key? key}) : super(key: key);

  @override
  State<ItemUser> createState() => _ItemUserState();
}

class _ItemUserState extends State<ItemUser> {
  bool isReceived = false;
  bool isSeen = true;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.grey,
      onLongPress: () {
        print("onLongPress");
      },
      onTap: () {
        setState(() {
          this.isSeen = !isSeen;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFF6F35A5),
                    borderRadius: BorderRadius.circular(100),
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
                    Tittle(
                        text: "Văn Liệu",
                        size: 18,
                        color: isSeen
                            ? Colors.black
                            : Color.fromARGB(255, 134, 134, 134)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Ago",
                      style: TextStyle(
                          fontWeight: isSeen ? FontWeight.bold : null,
                          color: isSeen
                              ? Colors.black
                              : Color.fromARGB(255, 134, 134, 134),
                          fontSize: 16),
                    )
                  ],
                )
              ],
            ),
            Icon(
              isReceived ? Icons.check_circle : Icons.check_circle_outline,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
