class ChatRoomModel {
  final String? id;
  final List? members;
  final String? lastMessage;
  final String? lasteMessageTime;
  final String? createdAt;

  ChatRoomModel({
    required this.lastMessage,
    required this.lasteMessageTime,
    required this.members,
    required this.id,
    required this.createdAt,
  });
  factory ChatRoomModel.fromjson(jsonData) {
    // the data is automatically decoded ,there's no need to manually decode it
    return ChatRoomModel(
      id: jsonData['id'],
      createdAt: jsonData['created_at'],
      members: jsonData['members'],
      lastMessage: jsonData['lastMessage'],
      lasteMessageTime: jsonData['lasteMessageTime'],
    );
  }
}
