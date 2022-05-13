import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/item/appBar/app_bar.dart';
import 'package:test/item/button/button.dart';
import 'package:test/item/textField/textfield_normal.dart';
import 'package:test/item/textField/username_textfield.dart';
import 'package:test/models/user.dart';
import 'package:test/preference/user_peference.dart';
import 'package:test/provider/edit_infor_provider.dart';
import 'package:test/provider/user_provider.dart';
import 'package:test/screens/profile_widget/my_profile/information_user.dart';

class EditInfor extends StatefulWidget {
  const EditInfor({
    Key? key,
    required this.title,
    required this.data,
    required this.content,
  }) : super(key: key);
  final String title;
  final String data;
  final String content;

  @override
  State<EditInfor> createState() => _EditInforState();
}

class _EditInforState extends State<EditInfor> {
  TextEditingController controller = TextEditingController();
  String? text;
  void initState() {
    super.initState();
    controller.text = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    EditInforProvider edit = Provider.of<EditInforProvider>(context);
    User user = Provider.of<UserProvider>(context).user;
    UserProvider _setuser = Provider.of<UserProvider>(context);
    setState(() {
      this.controller.text = controller.text;
    });
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          AppBarWidget(
              name: "Edit " + widget.title,
              onTap: () {
                Navigator.pop(context);
              },
              isDone: false),
          Container(
              height: MediaQuery.of(context).size.height * 0.8,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: controller,
                style: TextStyle(fontSize: 22),
              )),
          ButtonWidget(
              text: "Save",
              onTap: () {
                edit.editInfor(
                    widget.data, controller.text, user.iduser!, user.token!);
                print(user.iduser);
                print(user.token);
                print(user.username);
                print(user.about);
                // void foo() async {
                //   User _user = await edit.getUser(user.token!, user.iduser!);
                //   _setuser.setUser(_user);
                //   print(_user.token);
                //   print(_user.iduser);
                //   print(_user.username);
                //   print(_user.about);
                // }

                // foo();

                Navigator.pop(context);
              })
        ],
      ),
    ));
  }
}
