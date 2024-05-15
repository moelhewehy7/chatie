import 'package:chatie/features/home/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataInitial()) {
    getUserData();
  }

  getUserData() {
    String? myEmail = FirebaseAuth.instance.currentUser!.email;
    FirebaseFirestore.instance
        .collection("users")
        .doc(myEmail)
        .snapshots()
        .listen((event) {
      emit(UserDataSuccess(userModel: UserModel.fromjson(event)));
    });
  }

  Future<void> updateUserData(
      {required String firstName,
      required String lastName,
      required String imageUrl}) async {
    emit(UserDataLoading());
    String? myEmail = FirebaseAuth.instance.currentUser!.email;
    await FirebaseFirestore.instance.collection("users").doc(myEmail).update({
      "Firstname": firstName,
      "Lastname": lastName,
      "image": imageUrl,
    });
    emit(UserDataUpdating());
  }
}
