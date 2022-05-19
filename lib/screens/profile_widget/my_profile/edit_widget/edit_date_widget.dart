import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:test/item/button/button.dart';
import 'package:test/item/button/button_check.dart';

import 'package:test/item/tittle/tittle.dart';
import 'package:test/models/user.dart';

import 'package:test/provider/edit_infor_provider.dart';
import 'package:test/provider/user_provider.dart';

class EditDate extends StatefulWidget {
  const EditDate({
    Key? key,
    required this.data,
    required this.content,
  }) : super(key: key);

  final String data;
  final String content;

  @override
  State<EditDate> createState() => _EditDateState();
}

class _EditDateState extends State<EditDate> {
  String? token;
  Color color = Colors.black;
  String? date = "Choose Birthday";
  bool isLoading = false;
  void initState() {
    super.initState();

    if (widget.content.isNotEmpty) {
      date = widget.content;
      color = Colors.blue;
    }
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    EditInforProvider edit = Provider.of<EditInforProvider>(context);
    User user = Provider.of<UserProvider>(context).user;
    UserProvider _setuser = Provider.of<UserProvider>(context);

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
          InkWell(
            onTap: () async {
              final newDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(DateTime.now().year - 5),
                  lastDate: DateTime(DateTime.now().year + 5));
              if (newDate == null) return;
              setState(() {
                date = newDate.day.toString() +
                    " Tháng " +
                    newDate.month.toString() +
                    "," +
                    newDate.year.toString();
              });
            },
            child: Container(
                padding: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Tittle(text: date!, size: 24, color: Colors.black),
                    Icon(Icons.calendar_month_outlined)
                  ],
                )),
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

                    await edit.editInfor(
                        widget.data, date!, user.iduser!, token!);

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
