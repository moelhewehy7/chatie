import 'dart:io';
import 'package:chatie/features/chats/data/cubits/chat_cubit/chat_cubit.dart';
import 'package:chatie/features/groups/data/cubits/group_chats_cubit/group_chats_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class FirebaseHelper {
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

  Future addMember({required String groupId, required List members}) async {
    await FirebaseFirestore.instance
        .collection("groups")
        .doc(groupId)
        .update({"members": FieldValue.arrayUnion(members)});
    // is a method by Firestore that is used to update
    //an array field in a document by adding one or more elements
  }

  Future editGroup({
    required String groupId,
    required String name,
  }) async {
    await FirebaseFirestore.instance.collection("groups").doc(groupId).update({
      "name": name,
    });
    // is a method by Firestore that is used to update
    //an array field in a document by adding one or more elements
  }

  Future removeMember({required String groupId, required String member}) async {
    await FirebaseFirestore.instance.collection("groups").doc(groupId).update({
      "members": FieldValue.arrayRemove([member])
    });
  }

  Future promptAdmin(
      {required String groupId, required String memberId}) async {
    await FirebaseFirestore.instance.collection("groups").doc(groupId).update({
      "admins": FieldValue.arrayUnion([memberId])
    });
    // is a method by Firestore that is used to update
    //an array field in a document by adding one or more elements
  }

  Future removeAdimn(
      {required String groupId, required String memberId}) async {
    await FirebaseFirestore.instance.collection("groups").doc(groupId).update({
      "admins": FieldValue.arrayRemove([memberId])
    });
    // is a method by Firestore that is used to update
    //an array field in a document by adding one or more elements
  }
}

class FireStorage {
  final alternativeImage =
      "http://as2.ftcdn.net/v2/jpg/03/31/69/91/1000_F_331699188_lRpvqxO5QRtwOM05gR50ImaaJgBx68vi.jpg";
  final FirebaseStorage fireStorage = FirebaseStorage.instance;

  sendChatImage(BuildContext context,
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

  sendGroupImage(BuildContext context,
      {required String groupId, required File file}) async {
    String ext = file.path.split('.').last;
    String fileName =
        "images/$groupId/${DateTime.now().microsecondsSinceEpoch}.$ext";
    final ref = fireStorage.ref().child(fileName);
    await ref.putFile(file);
    String imageUrl = await ref.getDownloadURL();
    if (!context.mounted) return;
    BlocProvider.of<GroupChatsCubit>(context)
        .sendMessage(message: imageUrl, groupId: groupId, type: "image");
  }
}

//pick image by using image picker   ImagePicker imagePicker = ImagePicker();
// Initialize Firebase Storage.
//get extintion of the pic
// Specify Image Path.
// Upload Image.
// Get Image URL.



