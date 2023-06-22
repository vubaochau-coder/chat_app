import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/models/friend_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  FriendsBloc() : super(FriendsLoadingState()) {
    on<FriendsLoadingEvent>(loadingEvent);
    on<FriendsUpdateEvent>(updateEvent);
  }

  FutureOr<void> loadingEvent(
      FriendsLoadingEvent event, Emitter<FriendsState> emit) async {
    emit(FriendsLoadingState());

    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Friends')
        .snapshots()
        .listen((event) async {
      List<FriendModel> tempList = [];
      for (var ele in event.docs) {
        String docID = ele.id;
        String friendID = ele.get('id');
        String groupID = ele.get('chatGroup');
        String lastMessage = '';

        final friendQuery = await FirebaseFirestore.instance
            .collection('User')
            .doc(friendID)
            .get();
        String friendName = friendQuery.get('name');

        final groupchatQuery = await FirebaseFirestore.instance
            .collection('ChatGroup')
            .doc(groupID)
            .get();
        if (groupchatQuery.exists) {
          lastMessage = (groupchatQuery.data() as Map)['lastMessage'] ?? '';
        }

        tempList.add(FriendModel(
          friendID: friendID,
          name: friendName,
          lastMessage: lastMessage,
          docID: docID,
          chatGroupID: groupID,
        ));
      }

      add(FriendsUpdateEvent(newFriends: tempList));
    });
  }

  FutureOr<void> updateEvent(
      FriendsUpdateEvent event, Emitter<FriendsState> emit) {
    emit(FriendsLoadingSuccessfulState(friends: event.newFriends));
  }
}
