import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chat_app_new/logic/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> with HydratedMixin {
  UserCubit() : super(UserState()) {
    if (state.token == null) {
      addToken("");
    }
    if (state.currentUser == null) {
      addCurrentUser(User.emptyUser());
    }
  }

  void addToken(String token) => emit(UserState(token: token));
  void removeToken() =>
      emit(UserState(token: "", currentUser: User.emptyUser()));
  void addCurrentUser(User user) => emit(state.copyWith(currentUser: user));
  Future<void> signin(String email, String password) async {
    final response = await login(email, password);
    emit(UserState(token: response['token'], currentUser: response['user']));
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    return UserState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    return state.toMap();
  }
}
