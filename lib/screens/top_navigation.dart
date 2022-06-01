// ignore_for_file: type=lint
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:test/item/tittle/tittle.dart';
import 'package:test/models/user.dart';
import 'package:test/provider/user_provider.dart';

import 'package:test/screens/BarItem/home_page.dart';
import 'package:test/screens/BarItem/profile_page.dart';
import 'package:test/screens/BarItem/search_page.dart';
import 'package:test/screens/notify/notify_page.dart';

class NavigationBarSC extends StatefulWidget {
  const NavigationBarSC({Key? key}) : super(key: key);

  @override
  State<NavigationBarSC> createState() => _NavigationBarSCState();
}

class _NavigationBarSCState extends State<NavigationBarSC>
    with SingleTickerProviderStateMixin {
  int selectIndex = 0;
  late final TabController _tabController;
  late final ScrollController _scrollViewController;

  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    _scrollViewController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User _user = Provider.of<UserProvider>(context).user;
    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
          floatHeaderSlivers: true,
          controller: _scrollViewController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  automaticallyImplyLeading: false,
                  title: Tittle(
                      text: "SocialNetwork", size: 25, color: Colors.white),
                  actions: [
                    Stack(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NotifyPage()));
                            },
                            icon: Icon(Icons.notifications_none)),
                        Positioned(
                          top: 22,
                          left: 22,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 247, 103, 93),
                            ),
                            height: 20,
                            width: 20,
                            child: Center(
                              child: Text(
                                '1',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
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
                    tabs: <Widget>[
                      Tab(
                        icon: Icon(Icons.home),
                      ),
                      Tab(
                        icon: Icon(Icons.search),
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
            children: <Widget>[
              HomePage(),
              SearchPage(),
              ProfilePage(
                id: _user.iduser!,
                isBool: true,
              )
            ],
            controller: _tabController,
          )),
    );
  }
}
