import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_contact_state.dart';

class AddContactCubit extends Cubit<AddContactState> {
  AddContactCubit() : super(AddContactInitial());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String myEmail = FirebaseAuth.instance.currentUser!.email!;
  Future add({required String email}) async {
    try {
      emit(AddContactLoading());
      QuerySnapshot userQuery = await firestore
          .collection("users")
          .where("Email", isEqualTo: email)
          .get(); //
      if (userQuery.docs.isNotEmpty) {
        //to get the user email
        String userEmail = userQuery.docs.first.id;
        if (userEmail == myEmail) {
          emit(AddContactFailure(
              errMessage: "You can't add yourself as a contact"));
        } else {
          DocumentSnapshot contactQuery =
              await firestore.collection("users").doc(myEmail).get();
          if (contactQuery.get("myUsers").contains(userEmail) == false) {
            //check if user is already added as a contact
            firestore.collection("users").doc(myEmail).update({
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
//check if user exist
//check if user is not the current user
//check if user is already added as a contact
//add user as a contact
