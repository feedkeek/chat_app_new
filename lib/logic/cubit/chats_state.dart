part of 'chats_cubit.dart';

abstract class ChatsState extends Equatable {
  const ChatsState();

  @override
  List<Object> get props => [];
}

class ChatsLoading extends ChatsState {}

class ChatsLoaded extends ChatsState {}
