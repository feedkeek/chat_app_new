part of 'user_cubit.dart';

class UserState extends Equatable {
  final String? token;
  final User? currentUser;
  UserState({
    this.token,
    this.currentUser,
  });

  UserState copyWith({
    String? token,
    User? currentUser,
  }) {
    return UserState(
      token: token ?? this.token,
      currentUser: currentUser ?? this.currentUser,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'currentUser': currentUser?.toMap(),
    };
  }

  factory UserState.fromMap(Map<String, dynamic> map) {
    return UserState(
      token: map['token'],
      currentUser: map['currentUser'] == null
          ? User.emptyUser()
          : User.fromMap(map['currentUser']),
    );
  }

  String toJson() => jsonEncode(toMap());

  factory UserState.fromJson(String source) =>
      UserState.fromMap(jsonDecode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [token, currentUser];
}
