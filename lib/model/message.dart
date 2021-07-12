import 'package:flutter/material.dart';

import '../utils.dart';

class MessageField {
  static final String createdAt = 'createdAt';
  static final String read = 'read';
}

class Message {
  final String idUser;
  final String username;
  final String message;
  final String type;
  final bool read;
  final DateTime createdAt;

  const Message({
    @required this.idUser,
    @required this.read,
    @required this.username,
    @required this.message,
    @required this.type,
    @required this.createdAt,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
        idUser: json['idUser'],
        read: json['read'],
        username: json['username'],
        message: json['message'],
        type: json['type'],
        createdAt: Utils.toDateTime(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'read': read,
        'username': username,
        'message': message,
        'type': type,
        'createdAt': Utils.fromDateTimeToJson(createdAt),
      };
}

class Convo {
  final String id;
  final List<dynamic> userIds;
  final Map<dynamic, dynamic> lastMessage;
  final bool read;
  final int messageCount;
  Convo(
      {this.read, this.messageCount, this.id, this.userIds, this.lastMessage});

  static Convo fromJson(Map<String, dynamic> json) => Convo(
      id: json['id'],
      userIds: json["users"] ?? <dynamic>[],
      lastMessage: json['lastMessage'] ?? <dynamic>{},
      read: json['read'],
      messageCount: json['messageCount']);
}
