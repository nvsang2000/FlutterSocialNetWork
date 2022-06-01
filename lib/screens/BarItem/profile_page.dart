// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/item/image_widget/image.dart';
import 'package:test/item/tittle/tittle.dart';
import 'package:test/models/post.dart';
import 'package:test/models/user.dart';
import 'package:test/provider/post_provider.dart';
import 'package:test/provider/user_provider.dart';
import 'package:test/screens/all_image.dart';
import 'package:test/screens/posts/post_item.dart';
import 'package:test/screens/profile_widget/menu_widget.dart';
import 'package:test/screens/profile_widget/profile_user/information_user.dart';
import 'package:test/screens/profile_widget/profile_user/menu_2_widget.dart';
import 'package:test/screens/profile_widget/profile_user/top_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.isBool, required this.id})
      : super(key: key);
  final bool isBool;
  final String id;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double coverHeight = 200;
  double avartaHeight = 120;
  List<Post> list = [];
  User? _user;
  String? id;
  UserProvider? userProvider;
  PostProvider? postProvider;
  List<String> listImages = [];
  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
    userProvider!.getImages(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    double menuWidth = (MediaQuery.of(context).size.width - 40);
    _user = Provider.of<UserProvider>(context).user;

    postProvider = context.watch<PostProvider>();

    postProvider!.getMyPost(_user!.token!);
    list = postProvider!.getMyPostList;

    listImages = userProvider!.listImages;
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
                        _user!.username!,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        _user!.about!,
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
                              index: listImages.length,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Information()));
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      listImages.length > 0
                          ? Align(
                              child: Container(
                                width: double.infinity,
                                child: Stack(
                                  children: [
                                    Tittle(
                                        text: "Images",
                                        size: 24,
                                        color: Colors.black),
                                    listImages.length > 2
                                        ? Positioned(
                                            right: 0,
                                            bottom: 0,
                                            child: GestureDetector(
                                              child: Text(
                                                'See more...',
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 16),
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AllImagePage(
                                                                list:
                                                                    listImages)));
                                              },
                                            ))
                                        : Container()
                                  ],
                                ),
                              ),
                              alignment: Alignment.topLeft,
                            )
                          : Container(),
                      listImages.length > 0
                          ? Container(
                              height: 200,
                              child: Row(
                                children: [
                                  listImages.length > 0
                                      ? Expanded(
                                          child:
                                              ImageSee1(image: listImages[0]),
                                          flex: 1,
                                        )
                                      : Container(),
                                  listImages.length > 1
                                      ? Expanded(
                                          child:
                                              ImageSee2(image: listImages[1]),
                                          flex: 1,
                                        )
                                      : Container()
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: 10,
                      ),
                      list.length != 0
                          ? Align(
                              child: Tittle(
                                  text: "Posts", size: 24, color: Colors.black),
                              alignment: Alignment.topLeft,
                            )
                          : Container()
                    ],
                  ),
                )
              ],
            )),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => list.length != 0
                      ? ListView.builder(
                          reverse: true,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Stories(length:list.length,
                              comment: list[index].comment,
                              id: list[index].id,
                              token: _user!.token!,
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
}
