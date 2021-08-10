import 'dart:async';

import 'package:chat_app_new/logic/cubit/user_cubit.dart';
import 'package:chat_app_new/ui/common/form_input.dart';
import 'package:chat_app_new/ui/common/form_material_button.dart';
import 'package:chat_app_new/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.loginLoadingCallback,
    required this.loginThenCallback,
    required this.loginTimeoutCallback,
    required this.loginErrorCallback,
    required this.loginOnChangedCallback,
    this.errorText,
  }) : super(key: key);
  final Function loginLoadingCallback;
  final Function loginThenCallback;
  final Function loginTimeoutCallback;
  final Function loginErrorCallback;
  final Function loginOnChangedCallback;
  final String? errorText;
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () {
        // setState(() {
        //   errorText = null;
        // });
        widget.loginOnChangedCallback();
      },
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
            hintText: "example@mail.com",
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
          SizedBox(
            height: 12,
          ),
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
          SizedBox(
            height: 12,
          ),
          formMaterialButton(
            context: context,
            color: Theme.of(context).primaryColorDark,
            label: "Log In",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.loginLoadingCallback();

                BlocProvider.of<UserCubit>(context)
                    .signin(
                      _emailController.text,
                      _passwordController.text,
                    )
                    .then((value) => {widget.loginThenCallback()})
                    .catchError((error) {
                  if (error is TimeoutException) {
                    widget.loginTimeoutCallback();
                  } else {
                    widget.loginErrorCallback();
                  }
                });
              }
            },
            width: getWidth(context) * 0.9,
          ),
        ],
      ),
    );
  }
}
