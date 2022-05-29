import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:test/item/button/button_choose_image/button_image.dart';
import 'package:test/item/button/button_choose_image/image_dialog.dart';
import 'package:test/item/textField/textfield_normal.dart';
import 'package:test/item/tittle/tittle.dart';
import 'package:test/models/post.dart';
import 'package:test/models/user.dart';
import 'package:test/provider/post_provider.dart';
import 'package:test/provider/user_provider.dart';
import 'package:test/screens/auth/errorr_dialog.dart';
import 'package:test/screens/posts/type_post.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  User? _user;
  bool postBool = false;
  File? file;
  Post? post;
  PostProvider? _post;
  String? _iduser;
  TextEditingController controller = TextEditingController();
  // bool isImage = false;
  int typePostInt = 0;
  var typePostRow = [
    TypePost(
      type: "Friend",
      icon: Icons.people,
      isType: true,
    ),
    TypePost(
      type: "Just me",
      icon: Icons.person,
      isType: true,
    )
  ];
  var icon = [Icons.people, Icons.person];
  var tittle = ['Friend', 'Just me'];
  var ints = [0, 1];
  String? token;

  @override
  void initState() {
    // getToken();
    // getId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<UserProvider>(context).user;
    _post = Provider.of<PostProvider>(context);

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(children: [
            appBar(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(children: [
                inforUser(),
                contentPost(context),
                chooseImage(context)
              ]),
            )
          ])),
    );
  }

  Container appBar() {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            IconButton(
              splashColor: Colors.transparent,
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios, size: 20),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              "Create Post",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        Container(
            child: postBool
                ? Container(child: CircularProgressIndicator())
                : TextButton(
                    onPressed: () async {
                      if (controller.text != null && file != null) {
                        setState(() {
                          postBool = true;
                        });
                        await _post!.newPost(_user!.token!, controller.text,
                            typePostInt.toString(), file!);
                        controller.clear();
                        Navigator.pop(context);
                      } else
                        errorDialog(context,
                            {'message': 'Can you add photo or status?'});
                    },
                    child: Text(
                      "Post",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ))
      ]),
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
        file = imageTemporary;
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
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                _user!.avatarImage!,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) =>
                    loadingProgress == null
                        ? child
                        : Container(
                            height: 50,
                            width: 50,
                            child: Center(
                              child: CircularProgressIndicator(),
                            )),
                errorBuilder: (context, url, StackTrace? error) {
                  return Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF6F35A5),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.black, width: 1),
                      image: DecorationImage(
                          image: AssetImage('images/profile.jpg'),
                          fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Tittle(text: _user!.username!, size: 18, color: Colors.black),
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
        showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
            context: context,
            builder: (context) => Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Container(
                    height: 200,
                    child: Column(children: [
                      Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                height: 10,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey),
                              ),
                              Text(
                                "Who can see your posts?",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                      selectTypePost(context, tittle[0], icon[0], ints[0]),
                      selectTypePost(context, tittle[1], icon[1], ints[1]),
                    ]),
                  ),
                ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
        child: typePostRow[typePostInt],
      ),
    );
  }

  Expanded selectTypePost(
      BuildContext context, String tittle, IconData icon, int ints) {
    return Expanded(
        flex: 3,
        child: GestureDetector(
          onTap: () {
            setState(() {
              typePostInt = ints;
            });
            Navigator.of(context).pop();
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: typePostInt == ints
                          ? Color.fromARGB(255, 103, 187, 255)
                          : Color.fromARGB(255, 223, 223, 223))
                ]),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Radio(
                      value: ints,
                      groupValue: typePostInt,
                      onChanged: (value) {}),
                ),
                Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Tittle(text: tittle, size: 24, color: Colors.black),
                        Icon(icon)
                      ],
                    )),
              ],
            ),
          ),
        ));
  }

  // Future<String?> getToken() async {
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? _token = await pref.getString('token');
  //   setState(() {
  //     token = _token;
  //   });
  //   // print(token);
  //   return "Ok";
  // }

  // Future<void> getId() async {
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? id = pref.getString('_id');
  //   setState(() {
  //     _iduser = id;
  //   });
  // }
}
