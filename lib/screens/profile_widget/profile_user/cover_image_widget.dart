import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/item/button/button_choose_image/change_image.dart';

class CoverImageWidget extends StatefulWidget {
  const CoverImageWidget({
    Key? key,
    required this.urlImage,
    required this.onTap,
    required this.coverHeight,
  }) : super(key: key);
  final VoidCallback onTap;
  final double coverHeight;
  final String urlImage;

  @override
  State<CoverImageWidget> createState() => _CoverImageWidgetState();
}

class _CoverImageWidgetState extends State<CoverImageWidget> {
  var image;
  @override
  void initState() {
    image = NetworkImage(widget.urlImage);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.topRight,
          height: widget.coverHeight,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: image,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
        ),
        ChangeImageButton(
          onTap: widget.onTap,
          bottom: 10,
          right: 10,
        )
      ],
    );
  }
}
