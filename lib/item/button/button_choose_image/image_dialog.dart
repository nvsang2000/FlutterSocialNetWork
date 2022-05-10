import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/item/tittle/list_tittle_image.dart';

Future<void> imageDialog(
    BuildContext context, Future pickImage(ImageSource source)) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text("Choose Source")),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          content: Container(
            height: 145,
            child: Column(children: [
              ListTileWidget(
                  text: "From Camera",
                  icon: Icons.camera_alt,
                  onClicked: () {
                    pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  }),
              ListTileWidget(
                  text: "From Gallery",
                  icon: Icons.photo,
                  onClicked: () {
                    pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  })
            ]),
          ),
        );
      });
}
