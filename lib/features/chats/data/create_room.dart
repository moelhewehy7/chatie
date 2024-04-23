import 'package:chatie/core/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class Room {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String myEmail = FirebaseAuth.instance.currentUser!.email!;
  Future<void> create(
      {required String email, required BuildContext context}) async {
    QuerySnapshot userQuery = await FirebaseFirestore.instance
        .collection("users")
        .where("Email", isEqualTo: email)
        .get();

    if (userQuery.docs.isNotEmpty) {
      String userEmail = userQuery.docs.first.id;
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
          "lasteMessageTime": DateTime.now().millisecondsSinceEpoch.toString(),
          "members": members,
          "id": members.toString(),
          "createdAt": DateTime.now().millisecondsSinceEpoch.toString()
        });
      }
    } else {
      if (!context.mounted) return;
      showAlert(context,
          title: "Error", content: "User Not Found", buttonText: "Ok");
    }
  }
}
// if (myEmail == email) {
//       if (!context.mounted) return;
//       await showAlert(context,
//           title: "Error",
//           content: "Oops! you can't chat with yourself",
//           buttonText: "Ok");
//     }
// if (userQuery.docs.isNotEmpty) {
// 
// } else {
//   // Handle the case where no user with the specified email was found
//   print("No user found with email: $email");
// }


//In this case, the query is fetching documents from the "users" collection where the value of the "Email" field is equal to the provided email variable. Once the query is executed, the userQuery object contains the result, which is a list of documents (if any) that match the query criteria.The line String userEmail = userQuery.docs[0]["Email"]; extracts the value of the "Email" field from the first document in the query result (assuming there is at least one document in the result).