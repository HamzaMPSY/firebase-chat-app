class UserField {
  // static final String lastMessageTime = 'lastMessageTime';
  // static final String lastMessageId = 'lastMessageId';
}

class User {
  String idUser;
  String name;
  String urlAvatar;
  // String lastMessageId;
  // Message lastMessage;
  // DateTime lastMessageTime;

  User({
    this.idUser,
    this.name,
    this.urlAvatar,
    // this.lastMessageId,
    // this.lastMessage,
    // this.lastMessageTime
  });

  User copyWith({
    String idUser,
    String name,
    String urlAvatar,
    // String lastMessageId,
    // Message lastMessage,
    // DateTime lastMessageTime
  }) =>
      User(
        idUser: idUser ?? this.idUser,
        name: name ?? this.name,
        urlAvatar: urlAvatar ?? this.urlAvatar,
        // lastMessageId: lastMessageId ?? this.lastMessageId,
        // lastMessage: lastMessage ?? this.lastMessage,
        // lastMessageTime: lastMessageTime ?? this.lastMessageTime
      );

  static User fromJson(Map<String, dynamic> json) {
    User user = User(
      idUser: json['idUser'],
      name: json['name'],
      urlAvatar: json['urlAvatar'],
      // lastMessageId: json['lastMessageId'],
      // lastMessageTime: Utils.toDateTime(json['lastMessageTime'])
    );
    // List<String> ids = FirebaseApi.getChatId(user.idUser, myId);
    // String chatId = ids[0] + ids[1];
    // FirebaseFirestore.instance
    //     .collection('chats/$chatId/messages')
    //     .doc(user.lastMessageId)
    //     .get()
    //     .then((value) {
    //   print(value.get("message"));
    //   //user.lastMessageId = value['message'];
    // });
    return user;
  }

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'name': name,
        'urlAvatar': urlAvatar,
        // 'lastMessageId': lastMessageId,
        // 'lastMessage': lastMessage.toJson(),
        // 'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime)
      };

  // set lastMessageID(String messageid) {
  //   lastMessageId = messageid;
  // }
}
