import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test/item/textField/textfield_search.dart';
import 'package:test/screens/messeger/item_user.dart';

class MessengerPage extends StatefulWidget {
  const MessengerPage({Key? key}) : super(key: key);

  @override
  State<MessengerPage> createState() => _MessengerPageState();
}

class _MessengerPageState extends State<MessengerPage> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
          builder: (context) => CustomScrollView(
                slivers: <Widget>[
                  SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context)),
                  SliverToBoxAdapter(
                    child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFieldSearch(
                          controller: controller,
                        )),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => ItemUser(),
                    );
                  }, childCount: 1))
                ],
              )),
    );
  }
}
