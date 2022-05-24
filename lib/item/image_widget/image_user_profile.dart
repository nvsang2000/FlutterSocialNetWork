
import 'package:flutter/material.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget(
      {Key? key,
      required this.urlImage,
      required this.avartaHeight,
     
})
      : super(key: key);
  final String urlImage;
  final double? avartaHeight;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.network(
        widget.urlImage,
        height: widget.avartaHeight,
        width: widget.avartaHeight,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) =>
            loadingProgress == null
                ? child
                : Container(
                    height: widget.avartaHeight,
                    width: widget.avartaHeight,
                    child: Center(
                      child: CircularProgressIndicator(),
                    )),
        errorBuilder: (context, url, StackTrace? error) {
          return CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage("images/profile.jpg"),
          );
        },
      ),
    );
  }
}
