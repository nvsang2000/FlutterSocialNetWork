import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/item/appBar/app_bar.dart';

import 'package:test/item/button/button_choose_image/button_image.dart';

import 'package:test/item/button/button_choose_image/image_dialog.dart';
import 'package:test/item/textField/textfield_normal.dart';

import 'package:test/item/tittle/tittle.dart';
import 'package:test/screens/posts/type_post.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  File? file;
  TextEditingController controller = TextEditingController();
  // bool isImage = false;
  int typePostInt = 0;
  var typePostRow = TypePost(
    type: "Public",
    icon: Icons.public_sharp,
    isType: true,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(children: [
          AppBarWidget(
            name: "Create Post",
            onTap: () => Navigator.pop(context),
            isDone: true,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: [
              inforUser(),
              contentPost(context),
              chooseImage(context)
            ]),
          )
        ]),
      ),
    );
  }

  Row chooseImage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonImageWidget(
            text: "Choose Image",
            icon: Icons.camera_alt_outlined,
            onTap: () {
              imageDialog(context, pickImage);
            }),
        Container(
            child: file != null
                ? Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      ButtonImageWidget(
                          text: "Delete Image",
                          onTap: () {
                            setState(() {
                              this.file = null;
                            });
                          },
                          icon: Icons.delete_forever_outlined)
                    ],
                  )
                : null)
      ],
    );
  }

  Container contentPost(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.73,
      child: ListView(
        shrinkWrap: true,
        children: [
          TextFieldNormal(
              controller: controller, hintText: "What are you thinking?"),
          Container(
              child: file != null
                  ? Center(
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 2)),
                        child: Image.file(
                          file!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : null)
        ],
      ),
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
    } on PlatformException catch (e) {
      print("Failed to pick image $e");
    }
  }

  Row inforUser() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Color(0xFF6F35A5),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.black, width: 1),
                image: DecorationImage(
                    image: AssetImage('images/profile.jpg'), fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Tittle(text: "Văn Liệu", size: 18, color: Colors.black),
              SizedBox(
                height: 5,
              ),
              chooseTypeDialog()
            ])
          ],
        ),
      ],
    );
  }

  GestureDetector chooseTypeDialog() {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Center(child: Text("Choose Type Post")),
                content: Container(
                    height: 175,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Who can see your posts?",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          chooseType()
                        ])),
                actions: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
        child: typePostRow,
      ),
    );
  }

  ListView chooseType() {
    final value = [
      TypePost(type: "Public", icon: Icons.public_sharp, isType: false),
      TypePost(type: "Friend", icon: Icons.people, isType: false),
      TypePost(type: "Just Me", icon: Icons.person, isType: false)
    ];
    final value2 = [
      TypePost(type: "Public", icon: Icons.public_sharp, isType: true),
      TypePost(type: "Friend", icon: Icons.people, isType: true),
      TypePost(type: "Just Me", icon: Icons.person, isType: true)
    ];
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.grey[200],
              textStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          onPressed: () {
            if (this.mounted) {
              setState(() {
                this.typePostRow = value2[index];
                this.typePostInt = index;
                Navigator.pop(context);
              });
            }
          },
          child: Container(
            child: value[index],
            height: 30,
          ),
        );
      },
      itemCount: value.length,
    );
  }
}
