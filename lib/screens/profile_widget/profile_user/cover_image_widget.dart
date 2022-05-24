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
  bool errorFoundInImageLoad = false;
  @override
  void initState() {
    image = NetworkImage(widget.urlImage);

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
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            // child: CachedNetworkImage(
            //     imageUrl: widget.urlImage,
            //     fit: BoxFit.cover,
            //     placeholder: (context, url) => Center(
            //           child: CircularProgressIndicator(),
            //         ),
            //     errorWidget: (context, url, error) => new Icon(Icons.error)),
            child: Image.network(
              widget.urlImage,
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
                return Image.asset("images/background.png",fit: BoxFit.cover,);
              },
            ),
          ),
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
