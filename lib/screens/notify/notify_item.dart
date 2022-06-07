import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotifyItem extends StatelessWidget {
  const NotifyItem(
      {Key? key,
      required this.content,
      required this.image,
      required this.name})
      : super(key: key);
  final String content;
  final String image;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        width: double.infinity,
        height: 50,
        child: Row(
          children: [
            CachedNetworkImage(imageUrl: image),
            SizedBox(
              width: 20,
            ),
            Container(
                child: RichText(
              text: TextSpan(style: ColorBlack(), children: [
                TextSpan(
                    text: '$name ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                TextSpan(text: content),
              ]),
            )

                // RichText(TextSpan(style: ColorBlack(), children: [
                //   TextSpan(
                //       text: name,
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //       )),
                //   TextSpan(text: content),
                // ])),
                )
          ],
        ),
      ),
    );
  }
}

TextStyle ColorBlack() => TextStyle(color: Colors.black, fontSize: 16);
