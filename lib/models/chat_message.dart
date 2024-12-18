import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum MessageType {
  TEXT,
  IMAGE,
  UNKNOWN,
}

class ChatMessage {
  final String sender_id;
  final MessageType type;
  final String content;
  final DateTime sent_time;

  ChatMessage(
      {required this.sender_id,
      required this.type,
      required this.content,
      required this.sent_time});

  factory ChatMessage.fromJSON(Map<String, dynamic> _json) {
    MessageType _messageType;
    switch (_json["type"]) {
      case "text":
        _messageType = MessageType.TEXT;
        break;
      case "image":
        _messageType = MessageType.IMAGE;
        break;
      default:
        _messageType = MessageType.UNKNOWN;
    }

    return ChatMessage(
      sender_id: _json["sender_id"],
      type: _messageType,
      content: _json['content'],
      sent_time: _json['sent_time'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    String _messageType;
    switch (type) {
      case MessageType.TEXT:
        _messageType = "text";
        break;
      case MessageType.IMAGE:
        _messageType = "image";
        break;
      default:
        _messageType = "";
    }
    return {
      "content": content,
      "type": _messageType,
      "sender_id": sender_id,
      "sent_time": Timestamp.fromDate(sent_time),
    };
  }
}
