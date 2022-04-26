import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/item/tittle.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 10,
        ),
        Tittle(text: "Featured Stories", size: 18, color: Color(0xFF6F35A5)),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Stories(),
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) => Stories(),
                )
              ],
            ))
      ]),
    );
  }
}

class Stories extends StatelessWidget {
  const Stories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Color(0xFF6F35A5),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Color(0xFF6F35A5), width: 3),
              image: DecorationImage(
                  image: AssetImage('images/profile.jpg'), fit: BoxFit.cover),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Text(
              "User",
              style: TextStyle(fontSize: 16),
            ),
          )
        ]));
  }
}
