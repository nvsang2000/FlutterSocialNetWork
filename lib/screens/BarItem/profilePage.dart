import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/models/user.dart';
import 'package:test/preference/userPreference.dart';
import 'package:test/provider/authProvider.dart';
import 'package:test/provider/userProvider.dart';

import 'package:test/screens/auth/loginPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    User user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: Column(children: [
        SizedBox(height: 50),
        Text('${user.token}'),
        ElevatedButton(
            onPressed: () {
              // UserPreference().removeUser();
              auth.logout(user.token!);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text('logout'))
      ]),
    );
  }
}
