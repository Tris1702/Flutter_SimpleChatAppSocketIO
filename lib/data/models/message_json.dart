import 'dart:convert';

class MessageModel {
  String messagage;
  String senderName;
  MessageModel({
    required this.messagage,
    required this.senderName,
  });

  factory MessageModel.fromJson(dynamic source) => MessageModel(
      messagage: source['message'] as String,
      senderName: source['senderName'] as String);
  @override
  String toString() => 'MessageModel(messagage: $messagage, senderName: $senderName)';


  Map<String, dynamic> toMap() {
    return {
      'messagage': messagage,
      'senderName': senderName,
    };
  }
  String toJson() => json.encode(toMap());

}
