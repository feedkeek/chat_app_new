import 'package:chat_app_new/logic/cubit/user_cubit.dart';
import 'package:chat_app_new/ui/screens/home_screen.dart';
import 'package:chat_app_new/ui/screens/login_screen.dart';
import 'package:chat_app_new/ui/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => Builder(
            builder: (context) {
              try {
                final tokenCubit = context.watch<UserCubit>();
                if (tokenCubit.state.token == null)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                if (tokenCubit.state.token == "") return LoginScreen();
                return HomeScreen();
              } catch (e) {
                print(e);
                throw Exception("APPROUTER");
              }
            },
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      case '/login':
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
                .animate(animation),
            child: child,
          ),
        );
      case '/signup':
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              SignupScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
                .animate(animation),
            child: child,
          ),
        );
    }
  }
}
