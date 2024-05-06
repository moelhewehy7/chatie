import 'package:chatie/features/home/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fetch_contacts_state.dart';

class FetchContactsCubit extends Cubit<FetchContactsState> {
  FetchContactsCubit() : super(FetchContactsInitial());

  Future<void> fetchContacts() async {
    emit(FetchContactsLoading());
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .snapshots()
        .listen((event) {
      List myUsers = event.data()?["myUsers"]; //to get the list of contacts
      if (myUsers.isNotEmpty) {
        UserModel userModel = UserModel.fromjson(event.data()!);

        emit(FetchContactsSuccess(userModel: userModel));
      } else {
        emit(FetchContactsEmpty(message: "No contacts found"));
      }
    });
  }
}
