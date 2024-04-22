import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'chat_state.dart';

final myEmail = FirebaseAuth.instance.currentUser!.email;

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  Future sendMessage(
      {required String message,
      required String roomId,
      required String userEmail}) async {
    String msgId = const Uuid()
        .v1(); //t will generate a new, unique UUID based on the current time and the MAC address of the device.
    await FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomId)
        .collection("messages")
        .doc(msgId)
        .set({
      "id": msgId,
      "fromId": myEmail,
      "toId": userEmail,
      "read": "",
      "type": "text",
      "message": message,
      "createdAt": DateTime.now().toString()
    });
  }

  void getMessage() {}
}
