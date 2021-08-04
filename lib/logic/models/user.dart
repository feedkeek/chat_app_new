import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:chat_app_new/logic/utils/utils.dart';

class User {
  String username;
  String email;
  DateTime registrationDate;
  // String? profileImg;
  // List<User> friends;

  User({
    // this.profileImg,
    required this.username,
    required this.email,
    required this.registrationDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'registrationDate': registrationDate.millisecondsSinceEpoch,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      email: map['email'],
      registrationDate:
          DateTime.fromMillisecondsSinceEpoch(map['registrationDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

Future<Map<String, dynamic>> login(String email, String password) async {
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
      return {"token": body['token'], "user": User.fromJson(body['user'])};
    } else
      throw Exception(jsonDecode(res.body));
  } catch (e) {
    throw Exception(e);
  }
}

Future signup(String email, String username, String password) async {
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
  if (res.statusCode == 201) {
    return;
  } else {
    throw Exception(jsonDecode(res.body));
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
