// ignore_for_file: type=lint, unused_local_variable
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/item/button/button.dart';
import 'package:test/item/button/button_check.dart';
import 'package:test/item/textField/password_textfield.dart';

import 'package:test/item/textField/username_textfield.dart';

import 'package:test/item/tittle/tittle.dart';
import 'package:test/models/user.dart';
import 'package:test/provider/auth_provider.dart';
import 'package:test/provider/user_provider.dart';
import 'package:test/screens/auth/background.dart';
import 'package:test/screens/auth/errorr_dialog.dart';
import 'package:test/screens/auth/signup_page.dart';

import 'package:test/screens/top_navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    print("loginpage");
    Size size = MediaQuery.of(context).size;
    AuthProvider auth = Provider.of<AuthProvider>(context);
    void validate() {
      if (globalKey.currentState!.validate()) {
        final Future<Map<String, dynamic>> response =
            auth.login(username.text, password.text);
        response.then((response) {
          // print('checkaccout $response');

          if (response['status']) {
            setState(() {
              isLoading = false;
            });
            User user = response['user'];
            print(user.username);
            Provider.of<UserProvider>(context, listen: false).setUser(user);

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => NavigationBarSC(),
                ),
                (Route<dynamic> route) => false);
          } else {
            setState(() {
              isLoading = false;
            });
            errorDialog(context, response);
          }
        });
      }
      ;
    }

    return Scaffold(
      body: BackGround(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Tittle(text: "LOGIN", size: 25, color: Color(0xFF6F35A5)),
            SBox(30),
            Column(
              children: [
                Form(
                    key: globalKey,
                    child: Column(
                      children: [
                        UserNameTextField(
                          onChanged: (value) {},
                          controller: username,
                        ),
                        SBox(10),
                        PasswordTextField(
                          onChanged: (value) {},
                          hintText: "Password",
                          controller: password,
                        ),
                        SBox(30),
                        isLoading
                            ? ButtonCheck(text: "Login", onTap: () {})
                            : ButtonWidget(
                                text: "Login",
                                onTap: () {
                                  if (username.text.isNotEmpty &&
                                      password.text.isNotEmpty) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                  }
                                  validate();
                                }),
                        //     ? loading
                        // : ButtonWidget(
                        //     text: "Login",
                        //     onTap: () {
                        //       validate();
                        //     }),
                      ],
                    )),
                SBox(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "New account? ",
                      style: TextStyle(color: Color(0xFF6F35A5)),
                    ),
                    TextButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupPage())),
                        child: Text(
                          "Sign up now.",
                          style: TextStyle(
                              color: Color(0xFF6F35A5),
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ],
        ),
      )),
    );
  }

  SizedBox SBox(double size) {
    return SizedBox(
      height: size,
    );
  }
}
