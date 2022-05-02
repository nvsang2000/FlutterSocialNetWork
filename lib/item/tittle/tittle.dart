import 'package:flutter/cupertino.dart';

class Tittle extends StatefulWidget {
  const Tittle(
      {Key? key, required this.text, required this.size, required this.color})
      : super(key: key);
  final String text;
  final double size;
  final Color color;
  @override
  State<Tittle> createState() => _TittleState();
}

class _TittleState extends State<Tittle> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
          color: widget.color,
          fontSize: widget.size,
          fontWeight: FontWeight.bold),
    );
  }
}
