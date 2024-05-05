import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_contact_state.dart';

class AddContactCubit extends Cubit<AddContactState> {
  AddContactCubit() : super(AddContactInitial());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String myEmail = FirebaseAuth.instance.currentUser!.email!;
  Future add({required String email, required String roomId}) async {
    try {
      emit(AddContactLoading());
      final userQuery = await firestore
          .collection("users")
          .where("Email", isEqualTo: email)
          .get();
      String userEmail = userQuery.docs.first.id;
      if (userQuery.docs.isNotEmpty) {
        if (userEmail == myEmail) {
          emit(AddContactFailure(
              errMessage: "You can't add yourself as a contact"));
        } else {
          QuerySnapshot contactQuery = await firestore
              .collection("users")
              .where("myUsers", isEqualTo: email)
              .get();
          if (contactQuery.docs.isEmpty) {
            firestore.collection("users").doc(roomId).update({
              "myUsers": FieldValue.arrayUnion([userEmail])
              // is a method by Firestore that is used to update
              //an array field in a document by adding one or more elements
            });
            emit(AddContactSuccess());
          } else {
            emit(AddContactFailure(
                errMessage: "User already added as a contact"));
          }
        }
      } else {
        emit(AddContactFailure(errMessage: "User not found"));
      }
    } catch (e) {
      emit(AddContactFailure(
          errMessage: "Oops! Something went wrong, Try again later."));
    }
  }
}
