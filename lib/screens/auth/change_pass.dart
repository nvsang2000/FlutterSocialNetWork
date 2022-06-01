import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/item/button/button.dart';
import 'package:test/item/button/button_check.dart';
import 'package:test/item/textField/password_textfield.dart';
import 'package:test/item/tittle/tittle.dart';
import 'package:test/provider/auth_provider.dart';
import 'package:test/provider/comment_provider.dart';
import 'package:test/provider/post_provider.dart';
import 'package:test/provider/user_provider.dart';
import 'package:test/screens/auth/errorr_dialog.dart';

class ChangePassWidget extends StatefulWidget {
  const ChangePassWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePassWidget> createState() => _ChangePassWidgetState();
}

class _ChangePassWidgetState extends State<ChangePassWidget> {
  bool isChange = false;
  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController comfirmPass = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var auth = context.watch<AuthProvider>();
    var _user = Provider.of<UserProvider>(context).user;
    void validate() {
      if (globalKey.currentState!.validate()) {
        print("validate");
        if (newPass.text.endsWith(comfirmPass.text)) {
          auth
              .changePass(oldPass.text, newPass.text, _user.token!)
              .then((response) {
            print(response);
            if (response['status']) {
              setState(() {
                isChange = false;
              });
              errorDialog(context, response);
              auth.notify();
              Navigator.pop(context);
            } else {
              setState(() {
                isChange = false;
              });

              errorDialog(context, response);
              auth.notify();
            }
          });
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Error"),
                  content: Text("Password and Comfirm Password are incorrect"),
                  actions: [
                    FlatButton(
                      child: Text("Ok"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        }
      }
    }

    return Container(
      height: 400,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 5),
            height: 10,
            width: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.grey),
          ),
          Expanded(
            flex: 5,
            child: ListView(shrinkWrap: true, children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "Update Password",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6F35A5)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                  key: globalKey,
                  child: Column(
                    children: [
                      PasswordTextField(
                        onChanged: (value) {},
                        hintText: "Current Password",
                        controller: oldPass,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PasswordTextField(
                        onChanged: (value) {},
                        hintText: "New Password",
                        controller: newPass,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PasswordTextField(
                        onChanged: (value) {},
                        hintText: "Comfirm Password",
                        controller: comfirmPass,
                      ),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
            ]),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: isChange
                  ? ButtonCheck(text: "", onTap: () {})
                  : ButtonWidget(
                      text: "Login",
                      onTap: () {
                        if (oldPass.text.isNotEmpty &&
                            newPass.text.isNotEmpty &&
                            comfirmPass.text.isNotEmpty) {
                          setState(() {
                            isChange = true;
                          });
                        }
                        validate();
                      }),
            ),
            flex: 1,
          )
        ],
      ),
    );
  }
}
