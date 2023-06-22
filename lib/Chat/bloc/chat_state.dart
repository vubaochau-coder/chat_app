part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatLoadingState extends ChatState {}

class ChatLoadingSuccessfulState extends ChatState {
  final List<MessageModel> messaages;

  const ChatLoadingSuccessfulState({
    required this.messaages,
  });

  @override
  List<Object> get props => [messaages];
}
