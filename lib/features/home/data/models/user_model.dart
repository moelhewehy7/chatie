class UserModel {
  final String? id;
  final String? name;
  final String? firstName;
  final String? lastName;
  final String? bio;
  final String? email;
  final bool? lastSeen;
  final bool? isOnline;
  final String? createdAt;
  final String? profilePic;
  final String? pushToken;

  UserModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.name,
      required this.bio,
      required this.email,
      required this.lastSeen,
      required this.isOnline,
      required this.createdAt,
      required this.profilePic,
      required this.pushToken});
  factory UserModel.fromjson(jsonData) {
    // the data is automatically decoded ,there's no need to manually decode it
    return UserModel(
        id: jsonData['id'],
        name: jsonData['name'],
        firstName: jsonData['Firstname'],
        lastName: jsonData['Lastname'],
        bio: jsonData['bio'],
        email: jsonData['Email'],
        lastSeen: jsonData['last_seen'],
        isOnline: jsonData['is_online'],
        createdAt: jsonData['created_at'],
        profilePic: jsonData['profile_pic'],
        pushToken: jsonData['push_token']);
  }
}
//When you fetch data from Firebase, you receive a JSON representation of the data.
// then use your fromJson factory method to convert this JSON data into a UserModel object

// initializing your UserModel object when fetching data ensures 
//that your model reflects the actual data in your database