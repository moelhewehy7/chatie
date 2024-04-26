import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_chat_state.dart';

class CreateChatCubit extends Cubit<CreateChatState> {
  CreateChatCubit() : super(CreateChatInitial());

  Future<void> create({required String email}) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final String myEmail = FirebaseAuth.instance.currentUser!.email!;
    try {
      emit(CreateChatLoading());
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection("users")
          .where("Email", isEqualTo: email)
          .get();
      if (userQuery.docs.isNotEmpty) {
        String userEmail = userQuery.docs.first.id;
        // Check if the queried email is the same as the signed-in user's email
        if (userEmail == myEmail) {
          emit(CreateChatFailure(
              errMessage: "Cannot chat with yourself at this moment"));
        } else {
          final List members = [myEmail, userEmail]..sort(
              (a, b) => a.compareTo(b), //to sort members in alphabetical order
            );
          QuerySnapshot roomQuery = await FirebaseFirestore
              .instance //to check if there is room for the members or not
              .collection("rooms")
              .where("members", isEqualTo: members)
              .get();
          if (roomQuery.docs.isEmpty) {
            await firestore.collection("rooms").doc(members.toString()).set({
              "lastMessage": "lastMessage",
              "lasteMessageTime": "",
              "members": members,
              "id": members.toString(),
              "createdAt": DateTime.now().millisecondsSinceEpoch.toString()
            });
            emit(CreateChatSuccess());
          } else {
            emit(CreateChatFailure(errMessage: "Room Already Exists"));
          }
        }
      } else {
        emit(CreateChatFailure(errMessage: "User Not Found"));
      }
    } catch (e) {
      emit(CreateChatFailure(
          errMessage: "Oops! Something went wrong, Try again later."));
    }
  }
}
//  showAlert(context,
//               title: "Error", content: "User Not Found", buttonText: "Ok");