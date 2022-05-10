import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeImageButton extends StatelessWidget {
  const ChangeImageButton(
      {Key? key,
      required this.onTap,
      required this.right,
      required this.bottom})
      : super(key: key);
  final VoidCallback onTap;
  final double right;
  final double bottom;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: right,
      bottom: bottom,
      child: SizedBox(
        width: 40,
        height: 40,
        child: MaterialButton(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(color: Colors.white)),
          color: Colors.white,
          onPressed: onTap,
          child: Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }
}
