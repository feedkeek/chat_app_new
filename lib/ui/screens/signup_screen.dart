import 'package:chat_app_new/ui/common/form_material_button.dart';
import 'package:chat_app_new/ui/utils/utils.dart';
import 'package:chat_app_new/ui/widgets/signup_form.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? _errorText;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(
          "Sign Up",
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
                Spacer(flex: 2),
                Container(
                  width: getWidth(context) * 0.9,
                  child: SignupForm(
                    errorText: _errorText,
                    signupOnChangedCallback: () => setState(() {
                      _errorText = null;
                    }),
                    signupLoadingCallback: () => setState(() {
                      _isLoading = true;
                    }),
                    signupThenFailureCallback: () => setState(() {
                      _isLoading = false;
                      _errorText = "Invalid Data";
                    }),
                    signupTimeoutCallback: () => setState(() {
                      _isLoading = false;
                      _errorText = "No Internet Connection";
                    }),
                    signupErrorCallback: () => setState(() {
                      _isLoading = false;
                      _errorText = "Some error occured, please try later";
                    }),
                  ),
                ),
                Spacer(flex: 3),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: formMaterialButton(
                    context: context,
                    width: getWidth(context) * 0.9,
                    label: "Log In",
                    color: Theme.of(context).highlightColor,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
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
