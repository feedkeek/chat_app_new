import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'token_state.dart';

class TokenCubit extends Cubit<TokenState> with HydratedMixin {
  TokenCubit() : super(TokenState());

  void addToken(String token) => emit(TokenState(token: token));
  void removeToken() => emit(TokenState(token: null));

  @override
  TokenState? fromJson(Map<String, dynamic> json) {
    return TokenState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TokenState state) {
    return state.toMap();
  }
}
