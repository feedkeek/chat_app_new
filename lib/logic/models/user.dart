import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app_new/logic/utils/utils.dart';

class User extends Equatable {
  String? username;
  String? email;
  // DateTime? registrationDate;
  User({
    this.username,
    this.email,
  });

  factory User.emptyUser() {
    return User(username: "", email: "");
  }

  User copyWith({
    String? username,
    String? email,
  }) {
    return User(
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    try {
      return User(
        username: map['username'] == null ? null : map['username'],
        email: map['email'] == null ? null : map['email'],
      );
    } catch (e) {
      print(e);
      throw Exception("USER FROM MAP ERROR");
    }
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(username: $username, email: $email)';

  @override
  int get hashCode => username.hashCode ^ email.hashCode;

  @override
  // TODO: implement props
  List<Object?> get props => [username, email];
}

Future<dynamic> login(String email, String password) async {
  try {
    final res = await http
        .post(
          getUrl('/users/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, String>{
              'email': email,
              'password': password,
            },
          ),
        )
        .timeout(Duration(seconds: 10));

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return {
        "token": body['token'],
        "user": User.fromJson(jsonEncode(body['user']))
      };
    } else
      return res.statusCode;
  } catch (_) {
    // print("LOGIN FUNC $e");
    throw TimeoutException("No Internet Connection");
  }
}

Future<int> signup(String email, String username, String password) async {
  try {
    final res = await http
        .post(
          getUrl('/users'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': email,
            'username': username,
            'password': password,
          }),
        )
        .timeout(Duration(seconds: 10));
    return res.statusCode;
  } on TimeoutException catch (_) {
    throw TimeoutException("No Internet Connection");
  } catch (e) {
    throw Exception(e);
  }
}

Future logout(String jwt) async {
  final res = await http.post(getUrl('/users/me/logout'), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $jwt'
  });

  if (res.statusCode == 200) {
    return;
  } else {
    throw Exception(res.statusCode);
  }
}
