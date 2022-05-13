import 'package:flutter/cupertino.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    Key? key,
    required this.menu,
    required this.index,
    required this.width,
  }) : super(key: key);

  final String menu;
  final int index;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width / 4,
      child: Column(
        children: [
          Text(
            '$index',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            menu,
            style: TextStyle(color: Color.fromARGB(255, 146, 143, 143)),
          )
        ],
      ),
    );
  }
}
