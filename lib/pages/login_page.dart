import 'package:chatme/widgets/custom_input_field.dart';
import 'package:chatme/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double? _deviceHeigth, _deviceWidth;
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _deviceHeigth = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth! * 0.03, vertical: _deviceHeigth! * 0.02),
        height: _deviceHeigth! * 0.98,
        width: _deviceWidth! * 0.97,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _pageTitle(),
            SizedBox(
              height: _deviceHeigth! * 0.04,
            ),
            _loginForm(),
            SizedBox(
              height: _deviceHeigth! * 0.04,
            ),
            _loginButton(),
            SizedBox(
              height: _deviceHeigth! * 0.025,
            ),
            _signUpLink(),
          ],
        ),
      ),
    );
  }

  Widget _pageTitle() {
    return SizedBox(
      height: _deviceHeigth! * 0.1,
      child: const Text(
        "Chat me",
        style: TextStyle(
            color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _loginForm() {
    return SizedBox(
      height: _deviceHeigth! * 0.2,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomInputField(
                onSaved: (_value) {},
                regEx:
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                hint: "Email",
                obsecText: false),
            CustomInputField(
                onSaved: (_value) {},
                regEx: r".{8,}",
                hint: "Password",
                obsecText: true)
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return RoundedButton(
        name: "Login",
        height: _deviceHeigth! * 0.06,
        width: _deviceWidth! * 0.65,
        onPressed: () {});
  }

  Widget _signUpLink() {
    return GestureDetector(
      onTap: (){},
      child: const Text(
        "Don't have an Account",
        style: TextStyle(color: Colors.blueAccent),
      ),
    );
  }
}
