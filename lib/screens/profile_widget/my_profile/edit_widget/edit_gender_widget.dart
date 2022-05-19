import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:test/item/button/button.dart';
import 'package:test/item/button/button_check.dart';

import 'package:test/item/tittle/tittle.dart';
import 'package:test/models/user.dart';

import 'package:test/provider/edit_infor_provider.dart';
import 'package:test/provider/user_provider.dart';

class EditGender extends StatefulWidget {
  const EditGender({
    Key? key,
    required this.data,
    required this.content,
  }) : super(key: key);

  final String data;
  final String content;

  @override
  State<EditGender> createState() => _EditGenderState();
}

class _EditGenderState extends State<EditGender> {
  int? typeGender;
  String? token;
  Color color = Colors.black;
  bool isLoading = false;
  void initState() {
    super.initState();

    getToken();
    typeGender = int.parse(widget.content);
  }

  @override
  Widget build(BuildContext context) {
    EditInforProvider edit = Provider.of<EditInforProvider>(context);
    User user = Provider.of<UserProvider>(context).user;
    UserProvider _setuser = Provider.of<UserProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Radio(
                      value: 0,
                      groupValue: typeGender,
                      onChanged: (value) {
                        setState(() {
                          typeGender = value as int?;
                        });
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  Tittle(text: "Other", size: 20, color: Colors.black)
                ],
              ),
              Row(
                children: [
                  Radio(
                      value: 1,
                      groupValue: typeGender,
                      onChanged: (value) {
                        setState(() {
                          typeGender = value as int?;
                        });
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  Tittle(text: "Male", size: 20, color: Colors.black)
                ],
              ),
              Row(
                children: [
                  Radio(
                      value: 2,
                      groupValue: typeGender,
                      onChanged: (value) {
                        setState(() {
                          typeGender = value as int?;
                        });
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  Tittle(text: "Female", size: 20, color: Colors.black)
                ],
              ),
            ],
          ),
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

                    await edit.editInfor(widget.data, typeGender.toString(),
                        user.iduser!, token!);

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
