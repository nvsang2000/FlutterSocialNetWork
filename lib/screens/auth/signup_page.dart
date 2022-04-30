import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:test/item/button/button.dart';
import 'package:test/item/button/button_check.dart';
import 'package:test/item/textField/password_textfield.dart';
import 'package:test/item/textField/username_textfield.dart';
import 'package:test/item/tittle.dart';

import 'package:test/provider/auth_provider.dart';

import 'package:test/screens/auth/background.dart';
import 'package:test/screens/auth/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);
  bool isLoading = false;
  TextEditingController userName = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController comfirmPass = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> gl = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    void validate() {
      if (globalKey.currentState!.validate()) {
        auth.signedUpStatus = Status.Registering;
        auth.notify();
        print("validate");
        if (pass.text.endsWith(comfirmPass.text)) {
          auth.signup(userName.text, pass.text).then((response) {
            if (response['status']) {
              setState(() {
                isLoading = false;
              });
              auth.signedUpStatus = Status.SignedUp;
              auth.notify();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            } else {
              auth.signedUpStatus = Status.NotSignedUp;

              setState(() {
                isLoading = false;
              });
              auth.notify();
            }
          });
        }
      }
    }

    return Scaffold(
      body: BackGround(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Tittle(text: "SIGN UP", size: 25, color: Color(0xFF6F35A5)),
            SBox(30),
            Form(
              key: globalKey,
              child: Column(
                children: [
                  UserNameTextField(
                    onChanged: (value) {},
                    controller: userName,
                  ),
                  SBox(10),
                  PasswordTextField(
                    onChanged: (value) {},
                    hintText: "Password",
                    controller: pass,
                  ),
                  SBox(10),
                  PasswordTextField(
                      onChanged: (value) {},
                      hintText: "Comfirm Password",
                      controller: comfirmPass),
                  SBox(30),
                  isLoading
                      ? ButtonCheck(text: "SignUp", onTap: () {})
                      : ButtonWidget(
                          text: "Sign Up",
                          onTap: () {
                            isLoading = true;
                            validate();
                          }),
                  SBox(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "Are you ready? ",
                        style: TextStyle(color: Color(0xFF6F35A5)),
                      ),
                      TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage())),
                          child: Text(
                            "LogIn now.",
                            style: TextStyle(
                                color: Color(0xFF6F35A5),
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  SizedBox SBox(double int) => SizedBox(
        height: int,
      );
}
