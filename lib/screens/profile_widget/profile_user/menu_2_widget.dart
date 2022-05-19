import 'package:flutter/material.dart';
import 'package:test/preference/user_peference.dart';
import 'package:test/screens/auth/login_page.dart';

class Menu2Widget extends StatelessWidget {
  const Menu2Widget({
    Key? key,
    required this.onTap,
    required this.menuWidth,
  }) : super(key: key);
  final VoidCallback onTap;
  final double menuWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            width: menuWidth * 0.8,
            height: 35,
            child: Text(
              "MY PROFILE",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Colors.grey, width: 1)),
          ),
        ),
        Container(
          width: 35,
          height: 35,
          child: IconButton(
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              splashColor: Colors.transparent,
              onPressed: () {
                UserPreference().removeUser();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: Icon(Icons.settings_outlined)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: Colors.grey, width: 1)),
        )
      ],
    );
  }
}
