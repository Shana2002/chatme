import 'package:chatme/providers/authentication_provider.dart';
import 'package:chatme/services/media_service.dart';
import 'package:chatme/services/navigation_service.dart';
import 'package:chatme/widgets/custom_input_field.dart';
import 'package:chatme/widgets/rounded_button.dart';
import 'package:chatme/widgets/rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  double? _deviceHight, _deviceWidth;
  String? _email, _name, _password;
  final registerFormKey = GlobalKey<FormState>();
  NavigationService? _navigationService;
  PlatformFile? _profileImage;

  AuthenticationProvider? _auth;

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthenticationProvider>(context);
    _deviceHight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _navigationService = GetIt.instance.get<NavigationService>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: _deviceHight! * 0.03, horizontal: _deviceWidth! * 0.03),
        height: _deviceHight! * 0.97,
        width: _deviceWidth! * 0.98,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _profileImageView(),
            SizedBox(
              height: _deviceHight! * 0.05,
            ),
            _registerForm(),
            SizedBox(
              height: _deviceHight! * 0.05,
            ),
            _registerButton(),
            SizedBox(
              height: _deviceHight! * 0.02,
            ),
            _goBack(),
          ],
        ),
      ),
    );
  }

  Widget _profileImageView() {
    return GestureDetector(
      onTap: () {
        GetIt.instance
            .get<MediaService>()
            .pickImageFromLibrabry()
            .then((_file) {
          setState(() {
            _profileImage = _file;
          });
        });
      },
      child: () {
        if (_profileImage != null) {
          return RoundedImageFile(
              key: UniqueKey(),
              imagePath: _profileImage!,
              size: _deviceHight! * 0.15);
        } else {
          return RoundedImage(
              key: UniqueKey(),
              imagePath: "https://i.pravatar.cc/300",
              size: _deviceHight! * 0.15);
        }
      }(),
    );
  }

  Widget _registerForm() {
    return Container(
        height: _deviceHight! * 0.35,
        child: Form(
          key: registerFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomInputField(
                  onSaved: (_value) {
                    setState(() {
                      _name = _value;
                    });
                  },
                  regEx: r".{6,}",
                  hint: "Name",
                  obsecText: false),
              CustomInputField(
                  onSaved: (_value) {
                    setState(() {
                      _email = _value;
                    });
                  },
                  regEx:
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  hint: "Email",
                  obsecText: false),
              CustomInputField(
                  onSaved: (_value) {
                    setState(() {
                      _password = _value;
                    });
                  },
                  regEx: r".{8,}",
                  hint: "Password",
                  obsecText: true),
            ],
          ),
        ));
  }

  Widget _registerButton() {
    return RoundedButton(
      name: "Register",
      height: _deviceHight! * 0.06,
      width: _deviceWidth! * 0.65,
      onPressed: () async {
        print("object");
        if (registerFormKey.currentState!.validate() && _profileImage != null) {
          registerFormKey.currentState!.save();
          await _auth!.registerUserUsingEmailAndPAssword(
              _email!, _password!, _name!, _profileImage!);
          // String? imageUrl =
          //     await _cloudStorageService!.saveUserImage(uid!, _profileImage!);

          // print("image and auth done");
          // await _db!.createUser(uid, _email!, _name!, imageUrl!);
          _navigationService!.goBack();
        }
      },
    );
  }

  Widget _goBack() {
    return GestureDetector(
      onTap: () => _navigationService!.goBack(),
      child: const Text(
        "Already Have Account",
        style: TextStyle(color: Colors.blueAccent),
      ),
    );
  }
}
