import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/item/tittle/list_tittle_image.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({Key? key, required this.pickCamera}) : super(key: key);
  final Future pickCamera;
  @override
  Widget build(BuildContext context) => ListTileWidget(
      text: "From Camera", icon: Icons.camera_alt, onClicked: () {});
}
