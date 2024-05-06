class UserModel {
  // final String? id;
  // final String? name;
  final String? firstName;
  final String? lastName;
  final String? bio;
  final String? email;
  // final bool? lastSeen;
  // final bool? isOnline;
  final String? joinedOn;
  // final String? profilePic;
  // final String? pushToken;
  final List myUsers;
  UserModel({
    required this.myUsers,
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.email,
    required this.joinedOn,
  });
  factory UserModel.fromjson(jsonData) {
    // the data is automatically decoded ,there's no need to manually decode it
    return UserModel(
        // id: jsonData['id'],
        // name: jsonData['name'],
        firstName: jsonData['Firstname'],
        lastName: jsonData['Lastname'],
        bio: jsonData['bio'],
        email: jsonData['Email'],
        // lastSeen: jsonData['last_seen'],
        // isOnline: jsonData['is_online'],
        joinedOn: jsonData['JoinedOn'],
        // profilePic: jsonData['profile_pic'],
        // pushToken: jsonData['push_token'],
        myUsers: jsonData['myUsers']);
  }
}
//When you fetch data from Firebase, you receive a JSON representation of the data.
// then use your fromJson factory method to convert this JSON data into a UserModel object

// initializing your UserModel object when fetching data ensures 
//that your model reflects the actual data in your database