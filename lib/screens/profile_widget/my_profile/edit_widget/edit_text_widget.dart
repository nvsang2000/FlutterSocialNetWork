import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:test/item/button/button.dart';
import 'package:test/item/button/button_check.dart';

import 'package:test/models/user.dart';

import 'package:test/provider/edit_infor_provider.dart';
import 'package:test/provider/user_provider.dart';

class EditText extends StatefulWidget {
  const EditText({
    Key? key,
    required this.data,
    required this.content,
  }) : super(key: key);

  final String data;
  final String content;

  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  TextEditingController controller = TextEditingController();
  String? token;
  Color color = Colors.black;
  bool isLoading = false;
  void initState() {
    super.initState();
    controller.text = widget.content;
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    EditInforProvider edit = Provider.of<EditInforProvider>(context);
    User user = Provider.of<UserProvider>(context).user;
    UserProvider _setuser = Provider.of<UserProvider>(context);
    setState(() {
      this.controller.text = controller.text;
    });

    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    return Container(
      height: 150,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 5),
            height: 10,
            width: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.grey),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: controller,
                style: TextStyle(fontSize: 22),
              )),
          SizedBox(
            height: 20,
          ),
          isLoading
              ? ButtonCheck(text: "Save", onTap: () {})
              : ButtonWidget(
                  text: "Save",
                  onTap: () async {
                    setState(() {
                      isLoading = !isLoading;
                    });

                    await edit.editInfor(
                        widget.data, controller.text, user.iduser!, token!);

                    User _user = await edit.getUser(token!, user.iduser!);

                    _setuser.setUser(_user);

                    edit.notify();

                    Navigator.pop(context);
                  })
        ],
      ),
    );
  }

  Future<String?> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? _token = await pref.getString('token');
    setState(() {
      token = _token;
    });
    // print(token);
    return "Ok";
  }
}
