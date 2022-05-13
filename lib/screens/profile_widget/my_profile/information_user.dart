import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/item/appBar/app_bar.dart';
import 'package:test/item/tittle/tittle.dart';
import 'package:test/models/user.dart';
import 'package:test/provider/edit_infor_provider.dart';
import 'package:test/provider/user_provider.dart';
import 'package:test/screens/profile_widget/my_profile/edit_infor.dart';

class Information extends StatefulWidget {
  const Information({Key? key}) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    EditInforProvider edit = Provider.of<EditInforProvider>(context);

    var icon = [
      Icons.person_pin,
      Icons.edit,
      Icons.cake,
      Icons.location_on_outlined,
      Icons.person
    ];
    var title = ["Username", "About", "Birthday", "Address", "Gender"];
    var data = ["username", "about", "birthday", "address", "address"];
    var content = [
      user.username!,
      user.about!,
      user.birthday!,
      user.address!,
      user.address!
    ];
    return SafeArea(
        child: Scaffold(
      body: Column(children: [
        AppBarWidget(
            name: "Information",
            onTap: () {
              Navigator.pop(context);
            },
            isDone: false),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height * 0.893,
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return itemInfor(icon[index], title[index], content[index], () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditInfor(
                          content: content[index],
                          title: title[index],
                          data: data[index],
                        )));
              });
            },
          ),
        )
      ]),
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
              TextButton(
                onPressed: onTap,
                child: Text("Edit"),
                style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent)),
              )
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
                content,
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
