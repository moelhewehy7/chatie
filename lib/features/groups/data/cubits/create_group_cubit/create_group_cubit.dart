import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'create_group_state.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  CreateGroupCubit() : super(CreateGroupInitial());

  Future createGroup({required String groupName, required List members}) async {
    String groubId = const Uuid().v1();
    String myEmail = FirebaseAuth.instance.currentUser!.email!;
    members.add(myEmail);
    try {
      emit(CreateGroupLoading());
      await FirebaseFirestore.instance.collection("groups").doc(groubId).set({
        "id": groubId,
        "name": groupName,
        "image": "",
        "admins": [myEmail],
        "lastMessage": "",
        "lastMessageTime": DateTime.now().millisecondsSinceEpoch.toString(),
        "members": members,
        "createdAt": DateTime.now().millisecondsSinceEpoch.toString()
      });
      emit(CreateGroupSuccess());
    } catch (e) {
      emit(CreateGroupFailure(
          errMessage: "Oops, something went wrong, please try again later."));
    }
  }
}
