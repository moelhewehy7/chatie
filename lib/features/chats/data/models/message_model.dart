class MessageModel {
  final String? id;
  final String? fromId;
  final String? toId;
  final String? message;
  final String? createdAt;
  final String? read;
  final String? type;

  MessageModel(
      {this.id,
      this.fromId,
      this.toId,
      this.message,
      this.createdAt,
      this.read,
      this.type});
  factory MessageModel.fromjson(jsonData) {
    // the data is automatically decoded ,there's no need to manually decode it
    return MessageModel(
      id: jsonData['id'],
      fromId: jsonData['fromId'],
      toId: jsonData['toId'],
      message: jsonData['message'],
      createdAt: jsonData['createdAt'],
      read: jsonData['read'],
      type: jsonData['type'],
    );
  }
}
