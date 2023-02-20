class Message {
  String id;
  String senderId;
  String receiverId;
  int timestamp;
  String content;

  // String senderName;

  Message({required this.id,
    required this.senderId,
    required this.content,
    required this.receiverId,
    required this.timestamp});

  Message.fromJson(Map<String, dynamic> json)
      : this(
    id: json['id'],
    content: json['content'],
    senderId: json['senderId'],
    receiverId: json['receiverId'],
    timestamp: json['timestamp'],
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "content": content,
      "senderId": senderId,
      "receiverId": receiverId,
      "timestamp": timestamp,

    };
  }
}
