class UserModel {
  final String? firstName;
  final String? lastName;
  final String? bio;
  String? profilePic;
  final String? email;
  // final bool? lastSeen;
  // final bool? isOnline;
  final String? joinedOn;

  String? pushToken;
  final List myUsers;
  UserModel({
    required this.pushToken,
    required this.myUsers,
    required this.profilePic,
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.email,
    required this.joinedOn,
  });
  factory UserModel.fromjson(jsonData) {
    // the data is automatically decoded ,there's no need to manually decode it
    return UserModel(
        firstName: jsonData['Firstname'],
        lastName: jsonData['Lastname'],
        bio: jsonData['bio'],
        email: jsonData['Email'],
        // lastSeen: jsonData['lastSeen'],
        // isOnline: jsonData['isOnline'],
        joinedOn: jsonData['JoinedOn'],
        pushToken: jsonData['pushToken'],
        myUsers: jsonData['myUsers'],
        profilePic: jsonData['image']);
  }
}
//When you fetch data from Firebase, you receive a JSON representation of the data.
// then use your fromJson factory method to convert this JSON data into a UserModel object

// initializing your UserModel object when fetching data ensures 
//that your model reflects the actual data in your database