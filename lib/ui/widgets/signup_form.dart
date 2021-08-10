import 'dart:async';

import 'package:chat_app_new/ui/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:chat_app_new/logic/models/user.dart';
import 'package:chat_app_new/ui/common/form_input.dart';
import 'package:chat_app_new/ui/common/form_material_button.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({
    Key? key,
    required this.signupLoadingCallback,
    required this.signupThenFailureCallback,
    required this.signupTimeoutCallback,
    required this.signupErrorCallback,
    required this.signupOnChangedCallback,
    this.errorText,
  }) : super(key: key);
  final Function signupLoadingCallback;
  final Function signupThenFailureCallback;
  final Function signupTimeoutCallback;
  final Function signupErrorCallback;
  final Function signupOnChangedCallback;
  final String? errorText;
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () => widget.signupOnChangedCallback(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          textFormInput(
            _emailController,
            errorText: widget.errorText,
            fillColor: Theme.of(context).primaryColorLight,
            label: "Email",
            prefixIcon: Icon(
              Icons.email,
              size: 28,
              color: Theme.of(context).primaryColorDark,
            ),
            hintText: "example@gmail.com",
            validator: (value) {
              RegExp regExp = RegExp(
                "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$",
                caseSensitive: true,
                multiLine: false,
              );
              if (value == null || value.isEmpty || !regExp.hasMatch(value)) {
                return "Invalid Data";
              }
              return null;
            },
          ),
          SizedBox(height: 12),
          textFormInput(
            _usernameController,
            errorText: widget.errorText,
            fillColor: Theme.of(context).primaryColorLight,
            label: "Username",
            prefixIcon: Icon(
              Icons.person,
              size: 28,
              color: Theme.of(context).primaryColorDark,
            ),
            hintText: "example",
            validator: (String? value) {
              if (value!.isEmpty) {
                return "Username cannot be empty";
              }
              if (value.length < 2 || value.length > 20) {
                return "Username length cannot be less than 2 or more than 20";
              }
              return null;
            },
          ),
          SizedBox(height: 12),
          textFormInput(
            _passwordController,
            errorText: widget.errorText,
            fillColor: Theme.of(context).primaryColorLight,
            label: "Password",
            prefixIcon: Icon(
              Icons.lock,
              size: 28,
              color: Theme.of(context).primaryColorDark,
            ),
            obscure: true,
            hintText: "********",
            validator: (value) {
              if (value!.isEmpty) {
                return "Invalid data";
              }
              return null;
            },
          ),
          SizedBox(height: 12),
          formMaterialButton(
            context: context,
            color: Theme.of(context).primaryColorDark,
            label: "Log In",
            width: getWidth(context) * 0.9,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.signupLoadingCallback();
                signup(
                  _emailController.text,
                  _usernameController.text,
                  _passwordController.text,
                ).then((value) {
                  if (value == 201) {
                    Navigator.pushReplacementNamed(context, "/login");
                  } else if (value == 401) {
                    widget.signupThenFailureCallback();
                  }
                }).catchError((error) {
                  if (error is TimeoutException) {
                    widget.signupTimeoutCallback();
                  } else {
                    widget.signupErrorCallback();
                  }
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
