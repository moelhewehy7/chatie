import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Room {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String myEmail = FirebaseAuth.instance.currentUser!.email!;
  create({required String email}) async {
    QuerySnapshot userQuery = await FirebaseFirestore.instance
        .collection("users")
        .where("Email", isEqualTo: email)
        .get();
    String userEmail = userQuery.docs[0]["Email"];
    final List members = [myEmail, userEmail];
    await firestore.collection("rooms").doc(members.toString()).set({
      "lastMessage": "lastMessage",
      "lasteMessageTime": DateTime.now().toString(),
      "members": members,
      "id": members.toString(),
      "createdAt": DateTime.now().toString()
    });
  }
}

// if (userQuery.docs.isNotEmpty) {
// 
// } else {
//   // Handle the case where no user with the specified email was found
//   print("No user found with email: $email");
// }


//In this case, the query is fetching documents from the "users" collection where the value of the "Email" field is equal to the provided email variable. Once the query is executed, the userQuery object contains the result, which is a list of documents (if any) that match the query criteria.The line String userEmail = userQuery.docs[0]["Email"]; extracts the value of the "Email" field from the first document in the query result (assuming there is at least one document in the result).