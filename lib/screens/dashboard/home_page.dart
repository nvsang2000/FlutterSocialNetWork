import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/models/user.dart';
import 'package:test/preference/userPreference.dart';
import 'package:test/provider/userProvider.dart';
import 'package:test/screens/auth/changedScreen.dart';
import 'package:test/screens/auth/loginPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: Column(children: [
        SizedBox(height: 50),
        Text('${user.token}'),
        ElevatedButton(
            onPressed: () {
              UserPreference().removeUser();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text('logout'))
      ]),
    );
  }
}
