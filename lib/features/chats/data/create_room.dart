import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Room {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String myEmail = FirebaseAuth.instance.currentUser!.email!;
  Future<void> create({required String email}) async {
    QuerySnapshot userQuery = await FirebaseFirestore.instance
        .collection("users")
        .where("Email", isEqualTo: email)
        .get();
    if (userQuery.docs.isNotEmpty) {
      String userEmail = userQuery.docs.first.id;
      final List members = [myEmail, userEmail]..sort(
          (a, b) => a.compareTo(b),
        );
      QuerySnapshot roomQuery = await FirebaseFirestore.instance
          .collection("rooms")
          .where("members", isEqualTo: members)
          .get();
      if (roomQuery.docs.isEmpty) {
        await firestore.collection("rooms").doc(members.toString()).set({
          "lastMessage": "lastMessage",
          "lasteMessageTime": DateTime.now().toString(),
          "members": members,
          "id": members.toString(),
          "createdAt": DateTime.now().toString()
        });
      }
    }
  }
}

// if (userQuery.docs.isNotEmpty) {
// 
// } else {
//   // Handle the case where no user with the specified email was found
//   print("No user found with email: $email");
// }