part of 'token_cubit.dart';

class TokenState extends Equatable {
  final String? token;
  TokenState({
    this.token,
  });

  @override
  List<Object?> get props => [token];

  Map<String, dynamic> toMap() {
    return {
      'token': token,
    };
  }

  factory TokenState.fromMap(Map<String, dynamic> map) {
    return TokenState(
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenState.fromJson(String source) =>
      TokenState.fromMap(json.decode(source));
}
