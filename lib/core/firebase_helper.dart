import 'dart:io';
import 'package:chatie/features/chats/data/cubits/chat_cubit/chat_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future readMessage({required String roomId, required String msgId}) async {
  await FirebaseFirestore.instance
      .collection("rooms")
      .doc(roomId)
      .collection("messages")
      .doc(msgId)
      .update({"read": DateTime.now().millisecondsSinceEpoch.toString()});
}

Future deleteMessage(
    {required String roomId, required List<String> selectedMessage}) async {
  for (var msg in selectedMessage) {
    //to delete list of docs
    await FirebaseFirestore.instance
        .collection("rooms")
        .doc(roomId)
        .collection("messages")
        .doc(msg)
        .delete();
  }
}

class FireStorage {
  final FirebaseStorage fireStorage = FirebaseStorage.instance;
  sendImage(BuildContext context,
      {required String userEmail,
      required String roomId,
      required File file}) async {
    String ext = file.path.split('.').last;
    String fileName =
        "images/$roomId/${DateTime.now().microsecondsSinceEpoch}.$ext";
    final ref = fireStorage.ref().child(fileName);
    await ref.putFile(file);
    String imageUrl = await ref.getDownloadURL();
    if (!context.mounted) return;
    BlocProvider.of<ChatCubit>(context).sendMessage(
        message: imageUrl, roomId: roomId, userEmail: userEmail, type: "image");
  }
}

//pick image by using image picker   ImagePicker imagePicker = ImagePicker();      
// Initialize Firebase Storage.
//get extintion of the pic
// Specify Image Path.
// Upload Image.
// Get Image URL.
