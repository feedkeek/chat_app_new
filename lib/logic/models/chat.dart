import 'dart:convert';
import 'package:chat_app_new/logic/utils/utils.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app_new/logic/models/message.dart';
import 'package:chat_app_new/logic/models/user.dart';

class Chat {
  List<User> participants;
  List<Message> messages;
  String name;
  Chat({
    required this.participants,
    required this.messages,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'participants': participants.map((x) => x.toMap()).toList(),
      'messages': messages.map((x) => x.toMap()).toList(),
      'name': name,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      participants:
          List<User>.from(map['participants']?.map((x) => User.fromMap(x))),
      messages:
          List<Message>.from(map['messages']?.map((x) => Message.fromMap(x))),
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) => Chat.fromMap(json.decode(source));
}

Future<List<Chat>> fetchChats(String bearer) async {
  final res = await http.get(getUrl("/chats"), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $bearer'
  });
  if (res.statusCode == 200) {
    List<Chat> chats =
        jsonDecode(res.body).map<Chat>((data) => Chat.fromJson(data)).toList();
    return chats;
  } else {
    throw Exception("Failed to load chats");
  }
}

Future<Chat> fetchChat(String id, String bearer) async {
  final res = await http.get(getUrl("/chats/$id"), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $bearer'
  });
  if (res.statusCode == 200) {
    Chat chat = Chat.fromJson(jsonDecode(res.body));
    return chat;
  } else {
    throw Exception("Failed to load chat");
  }
}
