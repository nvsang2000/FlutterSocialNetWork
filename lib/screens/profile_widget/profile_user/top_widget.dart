import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/item/button/button_choose_image/image_dialog.dart';
import 'package:test/screens/profile_widget/profile_user/avarta_image_widged.dart';
import 'package:test/screens/profile_widget/profile_user/cover_image_widget.dart';

class TopWidget extends StatefulWidget {
  const TopWidget({
    Key? key,
    required this.coverHeight,
    required this.avartaHeight,
  }) : super(key: key);

  final double coverHeight;
  final double avartaHeight;

  @override
  State<TopWidget> createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopWidget> {
  File? file;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          child: CoverImageWidget(
              coverHeight: widget.coverHeight,
              onTap: () {
                imageDialog(context, pickImage);
              }),
          margin: EdgeInsets.only(bottom: widget.avartaHeight / 2),
        ),
        Positioned(
          top: widget.coverHeight - widget.avartaHeight / 2,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                  border: Border.all(width: 5, color: Colors.white)),
              child: AvartaImageWidget(
                avartaHeight: widget.avartaHeight,
                onTap: () {
                  imageDialog(context, pickImage);
                },
              )),
        ),
      ],
    );
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.file = imageTemporary;
      });
      print(file);
    } on PlatformException catch (e) {
      print("Failed to pick image $e");
    }
  }
}
