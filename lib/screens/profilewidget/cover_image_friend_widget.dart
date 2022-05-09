import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoverImageFriendWidget extends StatefulWidget {
  const CoverImageFriendWidget({
    Key? key,
    required this.coverHeight,
  }) : super(key: key);

  final double coverHeight;

  @override
  State<CoverImageFriendWidget> createState() => _CoverImageFriendWidgetState();
}

class _CoverImageFriendWidgetState extends State<CoverImageFriendWidget> {
  bool isFriend = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      height: widget.coverHeight,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/profile.jpg"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: button(),
    );
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: isFriend ? Colors.red : Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              onPressed: () {
                setState(() {
                  this.isFriend = !isFriend;
                });
              },
              child: tittleButton(),
            )
          ]),
    );
  }

  Row tittleButton() => Row(
        children: [
          Icon(
            isFriend ? Icons.person_remove : Icons.person_add,
            color: isFriend ? Colors.black : null,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            isFriend ? "Unfriend" : "Add Friend",
            style: TextStyle(
                color: isFriend ? Colors.black : null,
                fontWeight: FontWeight.bold),
          )
        ],
      );
}
