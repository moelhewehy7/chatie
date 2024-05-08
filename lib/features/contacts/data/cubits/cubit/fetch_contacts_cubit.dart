import 'dart:async';

import 'package:chatie/features/home/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fetch_contacts_state.dart';

class FetchContactsCubit extends Cubit<FetchContactsState> {
  FetchContactsCubit() : super(FetchContactsInitial());

  Future<void> fetchContacts() async {
    emit(FetchContactsLoading());
    try {
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.email)
          .snapshots()
          .listen((event) {
        List myUsers = event.data()?["myUsers"]; //to get the list of contacts
        if (myUsers.isNotEmpty) {
          //search for each contact and get each doc of each one
          FirebaseFirestore.instance
              .collection("users")
              .where("Email", whereIn: myUsers)
              .snapshots()
              .listen((event) {
            //return query snapshot of each user and then convet it to list of user model
            List<UserModel> userList = [];
            for (var doc in event.docs) {
              userList.add(UserModel.fromjson(doc));
            }
            emit(FetchContactsSuccess(users: userList));
          });
        } else {
          emit(FetchContactsEmpty(message: "No contacts found"));
        }
      });
    } catch (e) {
      emit(FetchContactsFailure(
          errMessage: "Oops something went wrong, try again later"));
    }
    // the _subscription variable is used to store the subscription to the Firestore snapshot. The subscription is canceled in the close method of the cubit,
    // ensuring that no new states are emitted after the cubit is closed.
  }
}

//get list of contacts from the current user
// check if list is empty or not
// If the list is not empty, it queries Firestore for user details based on the "myUsers" list.

//
// The "Bad state: Cannot add new events after calling close" error occurs
// when you attempt to emit a new state from a Cubit after it has been closed.
// In your case, the error likely occurred because the close() method was 
//called implicitly by the framework, possibly when the widget associated with the Cubit was disposed.
// Even though you didn't explicitly call close() on the Cubit,
// it's possible that the framework did so under certain circumstances, 
//such as when the widget that created the Cubit was disposed. When the Cubit is closed,
// any subsequent attempts to emit new states will result in the "Bad state" error.
// To prevent this error, ensure that you're not trying to emit new states from a Cubit after
// its associated widget has been disposed or after the Cubit has been explicitly closed.