// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/item/tittle.dart';
import 'package:test/screens/BarItem/homePage.dart';
import 'package:test/screens/BarItem/test.dart';

class NavigationBarSC extends StatefulWidget {
  const NavigationBarSC({Key? key}) : super(key: key);

  @override
  State<NavigationBarSC> createState() => _NavigationBarSCState();
}

class _NavigationBarSCState extends State<NavigationBarSC>
    with SingleTickerProviderStateMixin {
  int selectIndex = 0;
  late final TabController _tabController;
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        floatHeaderSlivers: true,
        scrollDirection: Axis.vertical,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                automaticallyImplyLeading: false,
                title: Tittle(
                    text: "SocialNetwork", size: 25, color: Colors.white),
                actions: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.search))
                ],
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.purple, Colors.red],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight),
                  ),
                ),
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  indicatorWeight: 2,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.home),
                    ),
                    Tab(
                      icon: Icon(Icons.notifications_none),
                    ),
                    Tab(
                      icon: Icon(Icons.menu),
                    )
                  ],
                  controller: _tabController,
                ),
              ),
            )
          ];
        },
        body: TabBarView(
          children: [Test(), Test(), Test()],
          controller: _tabController,
        ),
      ),
    );
  }
}