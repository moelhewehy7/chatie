import 'package:chatie/features/home/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataInitial());
  final myEmail = FirebaseAuth.instance.currentUser!.email;
  Future<void> updateUserData(
      {required String firstName,
      required String lastName,
      required String bio,
      required String imageUrl}) async {
    emit(UserDataLoading());
    await Future.delayed(const Duration(seconds: 2));
    await FirebaseFirestore.instance.collection("users").doc(myEmail).update({
      "Firstname": firstName,
      "Lastname": lastName,
      "image": imageUrl,
      "bio": bio
    });
  }

  getUserData() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(myEmail)
        .snapshots()
        .listen((event) {
      emit(UserDataSuccess(userModel: UserModel.fromjson(event)));
    });
  }
}
