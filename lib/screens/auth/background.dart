import 'package:flutter/cupertino.dart';

// ignore_for_file: type=lint
class BackGround extends StatelessWidget {
  final Widget child;
  const BackGround({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            child: Image.asset(
              "images/main_top.png",
              width: size.width * 0.3,
            ),
            top: 0,
            left: 0,
          ),
          Positioned(
            child: Image.asset(
              "images/main_bottom.png",
              width: size.width * 0.4,
            ),
            bottom: 0,
            left: 0,
          ),
          child
        ],
      ),
    );
  }
}
