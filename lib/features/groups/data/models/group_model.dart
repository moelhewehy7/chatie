class GroupModel {
  final String? id;
  final String? name;
  final String? joinedOn;
  final String? image;
  final String? lastMessage;
  final String? lastMessageTime;
  final List members;
  final List admins;
  GroupModel({
    required this.lastMessage,
    required this.lastMessageTime,
    required this.name,
    required this.image,
    required this.admins,
    required this.members,
    required this.id,
    required this.joinedOn,
  });
  factory GroupModel.fromjson(jsonData) {
    // the data is automatically decoded ,there's no need to manually decode it
    return GroupModel(
        id: jsonData['id'],
        name: jsonData['name'],
        image: jsonData['image'],
        admins: jsonData['admins'],
        members: jsonData['members'],
        joinedOn: jsonData['joinedOn'],
        lastMessage: jsonData['lastMessage'],
        lastMessageTime: jsonData['lastMessageTime']);
  }
}
