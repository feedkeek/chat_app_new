import 'dart:async';

import 'package:chat_app_new/ui/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app_new/logic/cubit/user_cubit.dart';
import 'package:chat_app_new/ui/common/form_input.dart';
import 'package:chat_app_new/ui/common/form_material_button.dart';
import 'package:chat_app_new/ui/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorText;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(
          "Log In",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: getWidth(context),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(
                  flex: 2,
                ),
                Container(
                  width: getWidth(context) * 0.9,
                  child: LoginForm(
                    loginOnChangedCallback: () => setState(() {
                      errorText = null;
                    }),
                    loginLoadingCallback: () => setState(() {
                      isLoading = true;
                    }),
                    loginThenCallback: () => setState(() {
                      isLoading = false;
                    }),
                    loginErrorCallback: () => setState(() {
                      isLoading = false;
                      errorText = "Invalid Data";
                    }),
                    loginTimeoutCallback: () => setState(() {
                      isLoading = false;
                      errorText = "No Internet Connection";
                    }),
                    errorText: errorText,
                  ),
                  // child: Form(
                  //   key: _formKey,
                  //   onChanged: () {
                  //     setState(() {
                  //       errorText = null;
                  //     });
                  //   },
                  //   child: Column(
                  //     mainAxisSize: MainAxisSize.min,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       textFormInput(
                  //         _emailController,
                  //         errorText: errorText,
                  //         fillColor: Theme.of(context).primaryColorLight,
                  //         label: "Email",
                  //         prefixIcon: Icon(
                  //           Icons.email,
                  //           size: 28,
                  //           color: Theme.of(context).primaryColorDark,
                  //         ),
                  //         hintText: "example@mail.com",
                  //         validator: (value) {
                  //           RegExp regExp = RegExp(
                  //             "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$",
                  //             caseSensitive: true,
                  //             multiLine: false,
                  //           );
                  //           if (value == null ||
                  //               value.isEmpty ||
                  //               !regExp.hasMatch(value)) {
                  //             return "Invalid Data";
                  //           }
                  //           return null;
                  //         },
                  //       ),
                  //       SizedBox(
                  //         height: 12,
                  //       ),
                  //       textFormInput(
                  //         _passwordController,
                  //         errorText: errorText,
                  //         fillColor: Theme.of(context).primaryColorLight,
                  //         label: "Password",
                  //         prefixIcon: Icon(
                  //           Icons.lock,
                  //           size: 28,
                  //           color: Theme.of(context).primaryColorDark,
                  //         ),
                  //         obscure: true,
                  //         hintText: "********",
                  //         validator: (value) {
                  //           if (value!.isEmpty) {
                  //             return "Invalid data";
                  //           }
                  //           return null;
                  //         },
                  //       ),
                  //       SizedBox(
                  //         height: 12,
                  //       ),
                  //       formMaterialButton(
                  //         color: Theme.of(context).primaryColorDark,
                  //         label: "Log In",
                  //         onPressed: () {
                  //           if (_formKey.currentState!.validate()) {
                  //             setState(() {
                  //               isLoading = true;
                  //               errorText = null;
                  //             });

                  //             _tokenCubit
                  //                 .signin(
                  //                   _emailController.text,
                  //                   _passwordController.text,
                  //                 )
                  //                 .then((value) => {
                  //                       setState(() {
                  //                         isLoading = false;
                  //                       })
                  //                     })
                  //                 .catchError((error) {
                  //               if (error is TimeoutException) {
                  //                 setState(() {
                  //                   isLoading = false;
                  //                   errorText = "No Internet Connection";
                  //                 });
                  //               } else {
                  //                 print('sd $error');
                  //                 setState(() {
                  //                   isLoading = false;
                  //                   errorText = "Invalid Data";
                  //                 });
                  //               }
                  //             });
                  //           }
                  //         },
                  //         width: getWidth(context) * 0.9,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ),
                Spacer(
                  flex: 3,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: formMaterialButton(
                    context: context,
                    width: getWidth(context) * 0.9,
                    label: "Sign Up",
                    color: Theme.of(context).highlightColor,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/signup');
                    },
                  ),
                )
              ],
            ),
          ),
          if (isLoading)
            Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.black.withOpacity(0.7),
                    child: Center(
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
