// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/item/appBar/app_bar.dart';
import 'package:test/item/tittle/tittle.dart';
import 'package:test/models/friend.dart';
import 'package:test/models/user.dart';
import 'package:test/provider/edit_infor_provider.dart';
import 'package:test/provider/user_provider.dart';
import 'package:test/screens/profile_widget/my_profile/edit_widget/edit_text_widget.dart';
import 'package:test/screens/profile_widget/profile_user/edit_widget/edit_date_widget.dart';
import 'package:test/screens/profile_widget/profile_user/edit_widget/edit_gender_widget.dart';


class InformationFriend extends StatefulWidget {
  const InformationFriend({Key? key,required this.userFriend}) : super(key: key);

  final UserFriend userFriend;
  @override
  State<InformationFriend> createState() => _InformationFriendState();
}

class _InformationFriendState extends State<InformationFriend> {
  @override
  Widget build(BuildContext context) {
  
    EditInforProvider edit = Provider.of<EditInforProvider>(context);

    var icon = [
      Icons.person_pin,
      Icons.edit,
      Icons.cake,
      Icons.location_on_outlined,
      Icons.person
    ];
    var title = ["Username", "About", "Birthday", "Address", "Gender"];
    var data = ["username", "about", "birthday", "address", "gender"];
    var content = [
      widget.userFriend.username!,
      widget.userFriend.about!,
      widget.userFriend.birthday!,
      widget.userFriend.address!,
      widget.userFriend.gender!.toString()
    ];
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        AppBarWidget(
          name: "Information",
          onTap: () {
            Navigator.pop(context);
          },
        ),
        RefreshIndicator(
          onRefresh: () async {
            User user = await Provider.of<UserProvider>(context).user;
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height * 0.893,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return itemInfor(icon[index], title[index], content[index], () {
                  if (title[index] == "Gender") {
                    showBottomWidget(context, data, index, content,
                        EditGender(data: data[index], content: content[index]));
                  } else if (title[index] == "Birthday") {
                    showBottomWidget(context, data, index, content,
                        EditDate(data: data[index], content: content[index]));
                  } else {
                    showBottomWidget(context, data, index, content,
                        EditText(data: data[index], content: content[index]));
                  }
                });
              },
            ),
          ),
        )
      ]),
    ));
  }

  Future<dynamic> showBottomWidget(BuildContext context, List<String> data,
      int index, List<String> content, Widget child) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: child,
            ));
  }

  Container itemInfor(
      IconData icon, String tittle, String content, VoidCallback onTap) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Tittle(text: tittle, size: 18, color: Colors.black),
            
            ],
          ),
          Row(
            children: [
              Icon(
                icon,
                color: Colors.grey,
                size: 28,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                tittle == "Gender"
                    ? content == "0"
                        ? "Other"
                        : content == "1"
                            ? "Male"
                            : "Female"
                    : content,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                maxLines: 1,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 2,
            color: Colors.grey,
            endIndent: 0,
          )
        ],
      ),
    );
  }
}
