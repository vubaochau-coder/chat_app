part of 'friends_bloc.dart';

abstract class FriendsState extends Equatable {
  const FriendsState();

  @override
  List<Object> get props => [];
}

class FriendsLoadingState extends FriendsState {}

class FriendsLoadingSuccessfulState extends FriendsState {
  final List<FriendModel> friends;

  const FriendsLoadingSuccessfulState({required this.friends});
}
