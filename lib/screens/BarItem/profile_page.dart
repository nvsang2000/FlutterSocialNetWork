// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/item/tittle/tittle.dart';
import 'package:test/models/post.dart';
import 'package:test/models/user.dart';
import 'package:test/provider/post_provider.dart';
import 'package:test/provider/user_provider.dart';
import 'package:test/screens/posts/post_item.dart';
import 'package:test/screens/profile_widget/menu_widget.dart';
import 'package:test/screens/profile_widget/profile_user/information_user.dart';
import 'package:test/screens/profile_widget/profile_user/menu_2_widget.dart';
import 'package:test/screens/profile_widget/profile_user/top_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.isBool}) : super(key: key);
  final bool isBool;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double coverHeight = 200;
  double avartaHeight = 120;
  List<Post> list = [];
  User? _user;
  String? token;
  String? _iduser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
    getId();
  }

  @override
  Widget build(BuildContext context) {
    double menuWidth = (MediaQuery.of(context).size.width - 40);

    User user = Provider.of<UserProvider>(context).user;
    if (token != null) {
      if (_iduser != null) {
        UserProvider userProvider = Provider.of<UserProvider>(context);
        userProvider.getUser(token!, _iduser!);
        _user = userProvider.userF;
      }
      PostProvider postProvider = Provider.of<PostProvider>(context);
      postProvider.getAllPostUser(token!);

      list = postProvider.getPostUserList;
    }
    return Scaffold(
        body: SafeArea(
      top: !widget.isBool,
      child: Builder(
        builder: (context) => CustomScrollView(
          slivers: <Widget>[
            widget.isBool
                ? SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                  )
                : SliverToBoxAdapter(),
            _user != null
                ? SliverToBoxAdapter(
                    child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: [
                      TopWidget(
                          coverHeight: coverHeight,
                          avatar: _user!.avatarImage!,
                          cover: _user!.coverImage!,
                          avartaHeight: avartaHeight,
                          isBool: widget.isBool),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              user.username!,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              user.about!,
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
                                MenuWidget(
                                    menu: "Post",
                                    index: list.length,
                                    width: menuWidth),
                                MenuWidget(
                                    menu: "Photos",
                                    index: 100,
                                    width: menuWidth),
                                MenuWidget(
                                    menu: "Followers",
                                    index: _user != null
                                        ? _user!.followers!.length
                                        : 999,
                                    width: menuWidth),
                                MenuWidget(
                                    menu: "Following",
                                    index: _user != null
                                        ? _user!.following!.length
                                        : 999,
                                    width: menuWidth),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Menu2Widget(
                              menuWidth: menuWidth * 0.8,
                              isBool: true,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Information()));
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            list.length != 0
                                ? Align(
                                    child: Tittle(
                                        text: "Posts",
                                        size: 24,
                                        color: Colors.black),
                                    alignment: Alignment.topLeft,
                                  )
                                : Container()
                          ],
                        ),
                      )
                    ],
                  ))
                : SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1),
                      child: Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ),
                  ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => token != null && list.length != 0
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Stories(
                              id: list[index].id,
                              token: token!,
                              userID: list[index].userID,
                              content: list[index].content,
                              image: list[index].images,
                              type: list[index].type,
                              avatar: list[index].avatar,
                              like: list[index].like,
                              createdAt: list[index].createdAt,
                              username: list[index].username),
                          itemCount: list.length,
                        )
                      : Container(),
                  childCount: 1),
            )
          ],
        ),
      ),
    ));
  }

  Future<void> getId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? id = pref.getString('_id');
    setState(() {
      _iduser = id;
    });
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
