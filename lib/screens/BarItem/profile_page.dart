// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/models/post.dart';
import 'package:test/models/user.dart';
import 'package:test/provider/post_provider.dart';
import 'package:test/provider/user_provider.dart';
import 'package:test/screens/posts/post_item.dart';
import 'package:test/screens/profile_widget/menu_widget.dart';
import 'package:test/screens/profile_widget/my_profile/information_user.dart';
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
  String? token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    double menuWidth = (MediaQuery.of(context).size.width - 40);

    User user = Provider.of<UserProvider>(context).user;
    if (token != null) {
      PostProvider postProvider =
          Provider.of<PostProvider>(context, listen: false
          
          
          
          
          
          
          
          
          
          );
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
            SliverToBoxAdapter(
                child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                TopWidget(
                    coverHeight: coverHeight,
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
                      Menu2Widget(
                        menuWidth: menuWidth * 0.8,
                        isBool: true,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Information(
                                    isBool: true,
                                  )));
                        },
                      )
                    ],
                  ),
                )
              ],
            )),
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
                      : Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.3),
                          child: Center(
                            child: SizedBox(
                              child: CircularProgressIndicator(),
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),
                  childCount: 1),
            )
          ],
        ),
      ),
    ));
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
