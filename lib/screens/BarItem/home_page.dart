import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/models/post.dart';
import 'package:test/provider/post_provider.dart';
import 'package:test/screens/posts/new_post.dart';
import 'package:test/screens/posts/post_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    PostProvider postProvider = Provider.of<PostProvider>(context);

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
                      return Container(
                        padding: EdgeInsets.only(top: 5),
                        color: Colors.white,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            CreatNewPost(),
                            ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (context, index) => UserOnl(),
                            )
                          ],
                        ),
                      );
                    }, childCount: 1),
                    itemExtent: 100),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return FutureBuilder(
                        future: postProvider.getAllPost(),
                        builder: (context,
                                AsyncSnapshot<List<Post>> snapshot) =>
                            snapshot.data != null
                                ? ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => Stories(
                                        content: snapshot.data![index].content,
                                        image: snapshot.data![index].images,
                                        type: snapshot.data![index].type),
                                    itemCount: snapshot.data!.length,
                                  )
                                : Container(
                                    margin: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.3),
                                    child: Center(
                                      child: SizedBox(
                                        child: CircularProgressIndicator(),
                                        height: 50,
                                        width: 50,
                                      ),
                                    ),
                                  ));
                  }, childCount: 1),
                )
                // SliverToBoxAdapter(
                //   child: ListView.builder(

                //     shrinkWrap: true,
                //     itemBuilder: (context, index) => Stories(),
                //     itemCount: 5,
                //   ),
                // )
              ],
            )),
      ),
    );
  }
}

class UserOnl extends StatelessWidget {
  const UserOnl({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            margin: EdgeInsets.only(right: 10, left: 10),
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("images/profile.jpg"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10, left: 10),
            child: Text(
              "User",
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
