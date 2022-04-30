// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/models/user.dart';

import 'package:test/provider/auth_provider.dart';
import 'package:test/provider/user_provider.dart';

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
              buildTop(),
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
                        buildMenu("Post", 100, menuWidth),
                        buildMenu("Photos", 100, menuWidth),
                        buildMenu("Followers", 100, menuWidth),
                        buildMenu("Following", 100, menuWidth),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    buildMenu2(menuWidth)
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    ));
    // Scaffold(
    //   body: Column(children: [
    //     SizedBox(height: 50),
    //     Text('${user.token}'),
    // ElevatedButton(
    //     onPressed: () {
    //       // UserPreference().removeUser();
    //       auth.logout(user.token!);
    //       Navigator.push(context,
    //           MaterialPageRoute(builder: (context) => LoginPage()));
    //     },
    //     child: Text('logout'))
    //   ]),
    // );
  }

  Row buildMenu2(double menuWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            width: menuWidth * 0.8,
            height: 35,
            child: Text(
              "EDIT PROFILE",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Colors.grey, width: 1)),
          ),
        ),
        Container(
          width: 35,
          height: 35,
          child: IconButton(
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              splashColor: Colors.transparent,
              onPressed: () {},
              icon: Icon(Icons.settings_outlined)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: Colors.grey, width: 1)),
        )
      ],
    );
  }

  Container buildMenu(String menu, int index, double width) {
    return Container(
      width: width / 4,
      child: Column(
        children: [
          Text(
            '$index',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            menu,
            style: TextStyle(color: Color.fromARGB(255, 146, 143, 143)),
          )
        ],
      ),
    );
  }

  Stack buildTop() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          child: buildCoverImage(),
          margin: EdgeInsets.only(bottom: avartaHeight / 2),
        ),
        Positioned(
          top: coverHeight - avartaHeight / 2,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                  border: Border.all(width: 5, color: Colors.white)),
              child: buildAvartaImage()),
        ),
      ],
    );
  }

  CircleAvatar buildAvartaImage() {
    return CircleAvatar(
      radius: avartaHeight / 2,
      backgroundColor: Colors.white,
      backgroundImage: AssetImage("images/profile.jpg"),
    );
  }

  Container buildCoverImage() {
    return Container(
      alignment: Alignment.topRight,
      height: coverHeight,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/profile.jpg"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      // child: Container(
      //   height: 50,
      //   width: 50,
      //   decoration: BoxDecoration(
      //       border: Border.all(width: 4, color: Color(0xFF6F35A5)),
      //       borderRadius: BorderRadius.all(Radius.circular(50))),
      //   child: IconButton(
      //     alignment: Alignment.center,
      //     onPressed: () {},
      //     icon: Icon(Icons.logout_outlined),
      //   ),
      // ),
    );
  }
}
