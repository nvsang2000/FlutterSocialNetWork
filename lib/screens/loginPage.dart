import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/item/button/button.dart';
import 'package:test/item/textField/passwordTextField.dart';
import 'package:test/item/textField/textField.dart';
import 'package:test/item/textField/usernameTextField.dart';

import 'package:test/item/tittle.dart';
import 'package:test/screens/background.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BackGround(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Tittle(text: "LOGIN", size: 25, color: Color(0xFF6F35A5)),
          Column(
            children: [
              UserNameTextField(
                onChanged: (value) {},
              ),
              SizedBox(
                height: 10,
              ),
              PasswordTextField(onChanged: (value) {}),
              SizedBox(
                height: 30,
              ),
              ButtonWidget(text: "Login", onTap: () {}),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    "Người dùng mới? ",
                    style: TextStyle(color: Color(0xFF6F35A5)),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Đăng ký ngay",
                        style: TextStyle(
                            color: Color(0xFF6F35A5),
                            fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ],
      )),
    );
  }
}
