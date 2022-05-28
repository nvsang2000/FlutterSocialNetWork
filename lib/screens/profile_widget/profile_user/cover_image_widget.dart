import 'package:flutter/material.dart';
import 'package:test/item/button/button_choose_image/change_image.dart';

class CoverImageWidget extends StatelessWidget {
  const CoverImageWidget(
      {Key? key,
      required this.urlImage,
      required this.onTap,
      required this.coverHeight,
      required this.isBool})
      : super(key: key);
  final VoidCallback onTap;
  final double coverHeight;
  final String urlImage;
  final bool isBool;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.topRight,
          height: coverHeight,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            child: Image.network(
              urlImage,
              height: coverHeight,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingProgress == null
                      ? child
                      : Container(
                          height: coverHeight,
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
        isBool
            ? Container()
            : IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
        ChangeImageButton(
          onTap: onTap,
          bottom: 10,
          right: 10,
        )
      ],
    );
  }
}
