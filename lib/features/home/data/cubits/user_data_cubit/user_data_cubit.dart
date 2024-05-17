import 'dart:async';

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

  Future<void> updateUserData(
      {required String firstName,
      required String lastName,
      required String bio,
      required String imageUrl}) async {
    final myEmail = FirebaseAuth.instance.currentUser!.email;
    print("${myEmail}this is my email");
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
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        //// the user's data should update correctly when they log in with a new account.
        FirebaseFirestore.instance
            .collection("users")
            .doc(user.email)
            .snapshots()
            .listen((event) {
          debugPrint("${user.email}this is my user.email");
          emit(UserDataSuccess(userModel: UserModel.fromjson(event)));
        });
      }
    });
  }

  // void resetData() {
  //   eventData.clear();
  //   emit(UserDataInitial());
  // }

  // @override
  // Future<void> close() {
  //   _subscription?.cancel();
  //   return super.close();
  // }
}
