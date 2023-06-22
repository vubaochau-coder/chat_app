part of 'friends_bloc.dart';

abstract class FriendsEvent extends Equatable {
  const FriendsEvent();

  @override
  List<Object> get props => [];
}

class FriendsLoadingEvent extends FriendsEvent {}

class FriendsUpdateEvent extends FriendsEvent {
  final List<FriendModel> newFriends;

  const FriendsUpdateEvent({required this.newFriends});
}
