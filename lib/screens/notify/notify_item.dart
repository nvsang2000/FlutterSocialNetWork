import 'package:flutter/cupertino.dart';

class NotifyItem extends StatelessWidget {
  const NotifyItem({Key? key, required this.content}) : super(key: key);
  final String content;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        width: double.infinity,
        height: 50,
        child: Text(content),
      ),
    );
  }
}
