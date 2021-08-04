import 'dart:convert';

class Message {
  String text;
  String from;
  DateTime time;
  Message({
    required this.text,
    required this.from,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'from': from,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      text: map['text'],
      from: map['from'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));
}
