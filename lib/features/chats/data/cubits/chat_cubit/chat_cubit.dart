import 'package:chatie/core/firebase_helper.dart';
import 'package:chatie/features/chats/data/models/message_model.dart';
import 'package:chatie/features/home/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  List<MessageModel> messages = [];
  Future sendMessage(
      {required String message,
      required UserModel userModel,
      required BuildContext context,
      String? type,
      required String roomId,
      required String userEmail}) async {
    final myEmail = FirebaseAuth.instance.currentUser!.email;
    String msgId = const Uuid()
        .v1(); //t will generate a new, unique UUID based on the current time and the MAC address of the device.
    await FirebaseFirestore.instance
        .collection("rooms")
        .doc(
            roomId) //so we can create messages in a specific room using the roomId
        .collection("messages")
        .doc(msgId)
        .set({
      "id": msgId,
      "fromId": myEmail,
      "toId": userEmail,
      "read": "",
      "type": type ?? "text",
      "message": message,
      "createdAt": DateTime.now().millisecondsSinceEpoch.toString()
    }).then((value) => FirebaseHelper().sendNotification(
            message: message, userModel: userModel, context: context));
    await FirebaseFirestore.instance.collection("rooms").doc(roomId).update({
      "lastMessage": type ?? message,
      "lasteMessageTime": DateTime.now().millisecondsSinceEpoch.toString()
    }); //so we can create m
  }

  void getMessage({required String roomId}) {
    messages
        .clear(); // Clear the messages list before fetching messages for the new chat
    try {
      FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomId)
          .collection('messages')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen((event) {
        messages
            .clear(); // to make sure to send just a new message not the whole list
        if (event.docs.isNotEmpty) {
          for (var doc in event.docs) {
            messages.add(MessageModel.fromjson(doc));
          }
          emit(ChatSuccess());
        } else {
          emit(ChatEmpty());
        }
      });
    } catch (e) {
      emit(ChatFailure());
    }
  }
}
