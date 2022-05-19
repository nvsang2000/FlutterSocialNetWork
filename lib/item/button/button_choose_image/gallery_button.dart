import 'package:flutter/material.dart';

import 'package:test/item/tittle/list_tittle_image.dart';

class GalleryButton extends StatelessWidget {
  const GalleryButton({Key? key, required this.pickImage}) : super(key: key);
  final Future pickImage;
  @override
  Widget build(BuildContext context) =>
      ListTileWidget(text: "From Gallery", icon: Icons.photo, onClicked: () {});
}
