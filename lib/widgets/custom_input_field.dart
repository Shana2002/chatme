import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final Function(String) onSaved;
  final String regEx;
  final String hint;
  final bool obsecText;

  const CustomInputField(
      {super.key,
      required this.onSaved,
      required this.regEx,
      required this.hint,
      required this.obsecText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (_value) => onSaved(_value!),
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      obscureText: obsecText,
      validator: (_value) {
        return RegExp(regEx).hasMatch(_value!) ? null : "Enter a valid value";
      },
      decoration: InputDecoration(
          fillColor: Color.fromRGBO(30, 29, 37, 1.0),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white54)),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final Function(String) onEdiditngComplete;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  IconData? icon;
  CustomTextField(
      {required this.onEdiditngComplete,
      required this.hintText,
      required this.obscureText,
      required this.controller,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onEditingComplete: () => onEdiditngComplete(controller.value.text),
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      obscureText: obscureText,
      decoration: InputDecoration(
          fillColor: Color.fromRGBO(30, 29, 37, 1.0),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white54),
          prefixIcon: Icon(icon,color: Colors.white,)),
    );
  }
}
