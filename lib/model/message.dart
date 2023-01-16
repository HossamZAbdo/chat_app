class Message {
  static String collectionName = 'message';
  String id;
  String content;
  int dateTime;
  String categoryId;
  String senderName ;
  String roomId ;
  String senderId ;

  Message(
      {this.id = '',
      required this.content,
      required this.dateTime,
      required this.categoryId,
        required this.senderName,
        required this.roomId,
        required this.senderId,

      });

  Message.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          content: json['content'] as String,
          dateTime: json['dateTime'] as int,
          categoryId: json['categoryId'] as String,
    senderName: json['senderName'] as String,
    roomId: json['roomId'] as String,
    senderId: json['senderId'] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'dateTime': dateTime,
      'categoryId': categoryId,
      'senderName': senderName,
      'roomId': roomId,
      'senderId': senderId,
    };
  }
}
