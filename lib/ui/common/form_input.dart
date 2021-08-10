import 'package:flutter/material.dart';

Widget textFormInput(
  TextEditingController controller, {
  Color fillColor: Colors.white,
  bool obscure = false,
  TextInputType textInputType = TextInputType.text,
  String label = "",
  String? hintText,
  Icon? prefixIcon,
  Icon? suffixIcon,
  Widget? prefix,
  Widget? suffix,
  String? Function(String?)? validator,
  String? errorText,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscure,
    keyboardType: textInputType,
    style: TextStyle(fontSize: 20),
    validator: validator,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      prefix: prefix,
      errorText: errorText,
      suffix: suffix,
      labelText: label,
      labelStyle: TextStyle(color: Colors.black),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintText: hintText,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          width: 1.0,
          color: Colors.red[400]!,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(
          width: 2.0,
          color: Colors.red,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          width: 1.0,
          color: Colors.blueGrey,
        ),
      ),
      fillColor: fillColor,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          width: 1.0,
          color: Colors.grey[350]!,
        ),
      ),
    ),
  );
}
