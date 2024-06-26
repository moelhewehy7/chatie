import 'dart:convert';
import 'dart:io';
import 'package:chatie/access_token_firebase.dart';
import 'package:chatie/features/chats/data/cubits/chat_cubit/chat_cubit.dart';
import 'package:chatie/features/groups/data/cubits/group_chats_cubit/group_chats_cubit.dart';
import 'package:chatie/features/groups/data/models/group_model.dart';
import 'package:chatie/features/home/data/cubits/user_data_cubit/user_data_cubit.dart';
import 'package:chatie/features/home/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> sendNotification(
      {required BuildContext context,
      String? groupname,
      required String message,
      required UserModel userModel}) async {
    final currentUser = BlocProvider.of<UserDataCubit>(context).userModel!;
    final accessTokenFirebase = AccessTokenFirebase();
    final accessToken = await accessTokenFirebase.getAccessToken();
    final header = {
      "Content-Type": "application/json",
      "Authorization":
          "Bearer $accessToken", //where a bearer token is provided to access protected resources.
    };
    if (!context.mounted) return;
    final body = {
      "message": {
        "token": userModel.pushToken,
        "notification": {
          "title": groupname == null
              ? "${currentUser.firstName!} ${currentUser.lastName!}"
              : "$groupname : ${currentUser.firstName!} ${currentUser.lastName!}",
          "body": message,
        },
      },
    };
    final response = await http.post(
      Uri.parse(
          "https://fcm.googleapis.com/v1/projects/chatie-e3450/messages:send"),
      body: jsonEncode(body),
      headers: header,
    );
    debugPrint("pushToken  ${userModel.pushToken}");
    debugPrint("pushToken  ${userModel.firstName}");
    debugPrint("pushToken  ${userModel.lastName}");
    debugPrint("status code ${response.statusCode}");
    //Uri.parse is used to ensure the URLs are correctly formed and we use post to send data to the server
  }

  Future updateToken({required String email, required String token}) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(email)
        .update({"pushToken": token});
  }

  Future updateStatus({
    required bool online,
  }) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.email!)
        .update({
      "Online": online,
      "lastSeen": DateTime.now().millisecondsSinceEpoch.toString()
    });
  }
}

class FireStorage {
  final alternativeImage =
      "http://as2.ftcdn.net/v2/jpg/03/31/69/91/1000_F_331699188_lRpvqxO5QRtwOM05gR50ImaaJgBx68vi.jpg";
  final FirebaseStorage fireStorage = FirebaseStorage.instance;

  sendChatImage(BuildContext context,
      {required String userEmail,
      required UserModel userModel,
      required String roomId,
      required File file}) async {
    String ext = file.path.split('.').last;
    String fileName =
        "images/$roomId/${DateTime.now().microsecondsSinceEpoch}.$ext";
    final ref = fireStorage.ref().child(fileName);
    await ref.putFile(file);
    String imageUrl = await ref.getDownloadURL();
    if (!context.mounted) return;
    BlocProvider.of<ChatCubit>(context)
        .sendMessage(
            userModel: userModel,
            context: context,
            message: imageUrl,
            roomId: roomId,
            userEmail: userEmail,
            type: "image")
        .then((value) => FirebaseHelper().sendNotification(
            context: context, message: "image", userModel: userModel));
  }

  sendGroupImage(
    BuildContext context, {
    required String groupId,
    required GroupModel groupModel,
    required File file,
  }) async {
    String ext = file.path.split('.').last;
    String fileName =
        "images/$groupId/${DateTime.now().microsecondsSinceEpoch}.$ext";
    final ref = fireStorage.ref().child(fileName);
    await ref.putFile(file);
    String imageUrl = await ref.getDownloadURL();
    if (!context.mounted) return;
    BlocProvider.of<GroupChatsCubit>(context).sendMessage(
        message: imageUrl,
        groupId: groupId,
        type: "image",
        context: context,
        groupModel: groupModel);
  }
}

//pick image by using image picker   ImagePicker imagePicker = ImagePicker();
// Initialize Firebase Storage.
//get extintion of the pic
// Specify Image Path.
// Upload Image.
// Get Image URL.
