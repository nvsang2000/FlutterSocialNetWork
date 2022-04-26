import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/item/tittle.dart';
import 'package:test/screens/BarItem/homePage.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Builder(
              builder: ((context) => CustomScrollView(
                    slivers: <Widget>[
                      SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context)),
                      SliverPadding(
                        padding: const EdgeInsets.all(10),
                        sliver: SliverFixedExtentList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                              return ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Stories(),
                                  ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: 5,
                                    itemBuilder: (context, index) => Stories(),
                                  )
                                ],
                              );
                            }, childCount: 1),
                            itemExtent: 90),
                      ),
                    ],
                  ))),
        ],
      ),
    );
  }
}
