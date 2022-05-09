// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/models/user.dart';

import 'package:test/provider/auth_provider.dart';
import 'package:test/provider/user_provider.dart';
import 'package:test/screens/profilewidget/menu_2_widget.dart';
import 'package:test/screens/profilewidget/menu_widget.dart';
import 'package:test/screens/profilewidget/top_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double coverHeight = 200;
  double avartaHeight = 120;

  @override
  Widget build(BuildContext context) {
    double menuWidth = (MediaQuery.of(context).size.width - 40);
    AuthProvider auth = Provider.of<AuthProvider>(context);
    User user = Provider.of<UserProvider>(context).user;

    return Scaffold(
        body: Builder(
      builder: (context) => CustomScrollView(
        slivers: <Widget>[
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverToBoxAdapter(
              child: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              TopWidget(coverHeight: coverHeight, avartaHeight: avartaHeight),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.username!,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Sở thích cá nhân.............. .................................................................................",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 150, 142, 142)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        MenuWidget(menu: "Post", index: 100, width: menuWidth),
                        MenuWidget(
                            menu: "Photos", index: 100, width: menuWidth),
                        MenuWidget(
                            menu: "Followers", index: 100, width: menuWidth),
                        MenuWidget(
                            menu: "Following", index: 100, width: menuWidth),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Menu2Widget(menuWidth: menuWidth)
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    ));
  }
}
