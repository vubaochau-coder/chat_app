part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatLoadingEvent extends ChatEvent {
  final String chatGroupID;

  const ChatLoadingEvent({required this.chatGroupID});
}

class ChatSendMessageEvent extends ChatEvent {
  final String message;
  final String groupID;

  const ChatSendMessageEvent({required this.message, required this.groupID});
}

class ChatUpdateEvent extends ChatEvent {
  final List<MessageModel> newMess;

  const ChatUpdateEvent({required this.newMess});
}
