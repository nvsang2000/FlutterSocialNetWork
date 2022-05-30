import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageSee1 extends StatelessWidget {
  const ImageSee1({Key? key, required this.image}) : super(key: key);
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: image,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class ImageSee2 extends StatelessWidget {
  const ImageSee2({Key? key, required this.image}) : super(key: key);
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: image,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
