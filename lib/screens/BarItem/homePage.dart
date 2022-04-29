import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/item/stories_item.dart/stories_item.dart';
import 'package:test/item/tittle.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            UserOnl(),
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
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Stories(),
                      itemCount: 5,
                    );
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
          // Container(
          //   margin: EdgeInsets.only(right: 10, left: 10),
          //   height: 70,
          //   width: 70,
          //   decoration: BoxDecoration(
          //     color: Color(0xFF6F35A5),
          //     borderRadius: BorderRadius.circular(100),
          //     border: Border.all(color: Color(0xFF6F35A5), width: 1),
          //     image: DecorationImage(
          //         image: AssetImage('images/profile.jpg'), fit: BoxFit.cover),
          //   ),
          // ),
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
              style: TextStyle(fontSize: 16),
            ),
          )
        ]));
  }
}
