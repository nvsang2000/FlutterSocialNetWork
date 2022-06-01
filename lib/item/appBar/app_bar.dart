import 'package:flutter/material.dart';
import 'package:test/screens/auth/change_pass.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget(
      {Key? key, required this.name, required this.onTap, required this.isBool})
      : super(key: key);
  final String name;
  final VoidCallback onTap;
  final bool isBool;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                splashColor: Colors.transparent,
                onPressed: onTap,
                icon: Icon(Icons.arrow_back_ios, size: 20),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          isBool
              ? IconButton(
                  onPressed: () => showModalBottomSheet(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15))),
                      context: context,
                      builder: (context) => Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: ChangePassWidget(),
                          )),
                  icon: Icon(
                    Icons.vpn_key,
                    color: Colors.black,
                  ))
              : Container()
        ],
      ),
    );
  }
}
