import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/des_algorithm.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatLoadingState()) {
    on<ChatLoadingEvent>(chatLoad);
    on<ChatSendMessageEvent>(sendMessage);
    on<ChatUpdateEvent>(updateChat);
  }

  FutureOr<void> chatLoad(
      ChatLoadingEvent event, Emitter<ChatState> emit) async {
    if (state is! ChatLoadingSuccessfulState) {
      emit(ChatLoadingState());
    }

    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('ChatGroup')
        .doc(event.chatGroupID)
        .collection('Message')
        .orderBy('sendingTime', descending: true)
        .snapshots()
        .listen((snapshotEvent) async {
      List<MessageModel> mess = [];

      if (snapshotEvent.docs.isNotEmpty) {
        for (var ele in snapshotEvent.docs) {
          Timestamp temp = ele.get('sendingTime');
          String id = ele.get('fromUser');
          String ciphertext = ele.get('message');

          String plaintext =
              await DESAlgorthm.decrypt(ciphertext, event.chatGroupID);

          mess.add(MessageModel(
            id: ele.id,
            message: plaintext,
            sendingTime: temp.toDate(),
            sendByMe: id == uid,
          ));
        }
      }

      add(ChatUpdateEvent(newMess: mess));
    });
  }

  FutureOr<void> sendMessage(
      ChatSendMessageEvent event, Emitter<ChatState> emit) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    String encryptedMess =
        await DESAlgorthm.encrypt(event.message, event.groupID);

    await FirebaseFirestore.instance
        .collection('ChatGroup')
        .doc(event.groupID)
        .collection('Message')
        .add({
      'message': encryptedMess,
      'fromUser': uid,
      'sendingTime': DateTime.now(),
    }).then((value) async {
      await FirebaseFirestore.instance
          .collection('ChatGroup')
          .doc(event.groupID)
          .set(
        {'lastMessage': encryptedMess},
        SetOptions(merge: true),
      );
    });
  }

  FutureOr<void> updateChat(ChatUpdateEvent event, Emitter<ChatState> emit) {
    if (state is ChatLoadingSuccessfulState) {
      final currentState = state as ChatLoadingSuccessfulState;

      List<MessageModel> temp = List.from(event.newMess);
      if (currentState.messaages.isNotEmpty) {
        currentState.messaages.clear();
      }

      emit(ChatLoadingSuccessfulState(messaages: temp));
    } else {
      emit(ChatLoadingSuccessfulState(messaages: event.newMess));
    }
  }
}
