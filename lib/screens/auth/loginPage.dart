import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/item/button/button.dart';
import 'package:test/item/textField/passwordTextField.dart';
import 'package:test/item/textField/textField.dart';
import 'package:test/item/textField/usernameTextField.dart';
import 'package:http/http.dart' as http;
import 'package:test/item/tittle.dart';
import 'package:test/models/user.dart';
import 'package:test/provider/authProvider.dart';
import 'package:test/provider/userProvider.dart';
import 'package:test/screens/auth/background.dart';
import 'package:test/screens/auth/signupPage.dart';
import 'package:test/screens/dashboard/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [CircularProgressIndicator(), Text("Login...Please wait!")],
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthProvider auth = Provider.of<AuthProvider>(context);
    void validate() {
      if (globalKey.currentState!.validate()) {
        print('login');
        final Future<Map<String, dynamic>> response =
            auth.login(username.text, password.text);
        response.then((response) {
          if (response['status']) {
            User user = response['user'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            print(user.token);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
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
                        auth.loggedInStatus == Status.Authenticating
                            ? loading
                            : ButtonWidget(
                                text: "Login",
                                onTap: () {
                                  validate();
                                }),
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
