import 'package:chat_app_new/logic/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(
          "Home",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return Text(
                  "${state.currentUser!.email}",
                  style: TextStyle(
                      color: Theme.of(context).primaryColorLight, fontSize: 36),
                );
              },
            ),
            MaterialButton(
              color: Colors.amber,
              elevation: 12.0,
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              child: Text("Log In Screen"),
            ),
            MaterialButton(
              color: Colors.deepOrange[800],
              elevation: 12.0,
              onPressed: () {
                Navigator.of(context).pushNamed('/signup');
              },
              child: Text("SignUp Screen"),
            ),
          ],
        ),
      ),
    );
  }
}
