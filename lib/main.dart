import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:chat_app_new/logic/cubit/user_cubit.dart';
import 'package:chat_app_new/ui/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  runApp(ChatApp(
    appRouter: AppRouter(),
  ));
}

class ChatApp extends StatelessWidget {
  const ChatApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          highlightColor: Color.fromARGB(255, 240, 113, 103),
          primaryColor: Color.fromARGB(255, 0, 175, 185),
          primaryColorDark: Color.fromARGB(255, 0, 129, 167),
          primaryColorLight: Color.fromARGB(255, 253, 252, 220),
          accentColor: Color.fromARGB(255, 254, 217, 183),
          textTheme: TextTheme(
            bodyText1: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
