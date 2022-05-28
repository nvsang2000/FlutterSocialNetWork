import 'package:flutter/material.dart';

class CoverImageFriendWidget extends StatefulWidget {
  const CoverImageFriendWidget({
    Key? key,
    required this.coverHeight,
    required this.urlImage,
  }) : super(key: key);
  final String urlImage;
  final double coverHeight;

  @override
  State<CoverImageFriendWidget> createState() => _CoverImageFriendWidgetState();
}

class _CoverImageFriendWidgetState extends State<CoverImageFriendWidget> {
  bool isFriend = false;
  @override
  Widget build(BuildContext context) {
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
