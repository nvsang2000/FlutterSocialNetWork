import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/item/tittle/tittle.dart';
import 'package:test/models/post.dart';
import 'package:test/models/user.dart';
import 'package:test/models/users.dart';
import 'package:test/provider/friend_provider.dart';
import 'package:test/provider/post_provider.dart';
import 'package:test/provider/user_provider.dart';
import 'package:test/screens/posts/new_post.dart';
import 'package:test/screens/posts/post_item.dart';
import 'package:test/screens/profile_widget/friend/profile_friend_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> list = [];
  List<Users> listUser = [];
  int? current;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    var userProvider = context.watch<UserProvider>();
    userProvider.getAllUserForUser();
    listUser = userProvider.getAllUserForUserList;
    var postProvider = context.watch<PostProvider>();
    postProvider.getAllPost(listUser, user.iduser!);
    list = postProvider.getAllList;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      resizeToAvoidBottomInset: true,
      body: Builder(
        builder: ((context) => CustomScrollView(
              // scrollDirection: Axis.vertical,
              slivers: <Widget>[
                SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context)),
                SliverFixedExtentList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return ChangeNotifierProvider(
                        create: (_) => UserProvider(),
                        child: Container(
                          padding: EdgeInsets.only(top: 5),
                          color: Colors.white,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              CreatNewPost(),
                              ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: listUser.length,
                                itemBuilder: (context, index) {
                                  return UserOnl(
                                      // userFriend: userFriend!,
                                      listFollow: user.following!,
                                      token: user.token!,
                                      name: listUser[index].username!,
                                      id: listUser[index].iduser!,
                                      image: listUser[index].avatarImage!);
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    }, childCount: 1),
                    itemExtent: 100),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => user.token != null && list.length != 0
                          ? ListView.builder(
                              reverse: true,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Stories(
                                  length: list.length,
                                  comment: list[index].comment,
                                  id: list[index].id,
                                  token: user.token!,
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
                                  top:
                                      MediaQuery.of(context).size.height * 0.3),
                              child: Center(
                                child: SizedBox(
                                  child: Tittle(
                                      text: "No Post",
                                      size: 20,
                                      color: Colors.red),
                                  height: 50,
                                  width: 100,
                                ),
                              ),
                            ),
                      childCount: 1),
                )
              ],
            )),
      ),
    );
  }
}

class UserOnl extends StatelessWidget {
  const UserOnl(
      {Key? key,
      // required this.userFriend,
      required this.image,
      required this.name,
      required this.listFollow,
      required this.id,
      required this.token})
      : super(key: key);
  final String image;
  // final UserFriend userFriend;
  final String name;
  final List<String> listFollow;
  final String id;
  final String token;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FriendProvider friend = context.read<FriendProvider>();
          friend.clearUser;
          PostProvider postProvider =
              Provider.of<PostProvider>(context, listen: false);
          postProvider.clearListPost;
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ProfileFriendPage(
              // userFriend: userFriend,
              userID: id,
              token: token,
              listFollow: listFollow,
            );
          }));
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            height: 70,
            width: 70,
            margin: EdgeInsets.only(right: 10, left: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, url, StackTrace? error) {
                  return ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: Image.asset(
                      "images/background.png",
                      fit: BoxFit.cover,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) =>
                    loadingProgress == null
                        ? child
                        : Container(
                            child: Center(
                            child: CircularProgressIndicator(),
                          )),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10, left: 10),
            child: Text(
              name.length > 6 ? name.substring(0, 6) + '...' : name,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 88, 86, 86)),
            ),
          )
        ]));
  }
}

class CreatNewPost extends StatelessWidget {
  const CreatNewPost({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewPost()));
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          DottedBorder(
            color: Colors.grey,
            strokeWidth: 2,
            radius: Radius.circular(50),
            borderType: BorderType.Circle,
            child: Container(
              height: 66,
              width: 66,
              margin: EdgeInsets.only(right: 10, left: 10),
              child: Icon(Icons.add),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10, left: 10),
            child: Text(
              "New Post",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 88, 86, 86)),
            ),
          )
        ]));
  }
}
