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
            for (var element in event.docs) {
              userList.add(UserModel.fromjson(element));
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
  }
}

//get list of contacts from the current user
// check if list is empty or not
// If the list is not empty, it queries Firestore for user details based on the "myUsers" list.