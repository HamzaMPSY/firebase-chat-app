import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_example/data.dart';
import 'package:firebase_chat_example/model/message.dart';
import 'package:firebase_chat_example/model/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import '../utils.dart';

class FirebaseApi {
  static Stream<List<Convo>> getConvos(String uid) => FirebaseFirestore.instance
      .collection("chats")
      .orderBy('lastMessage.createdAt', descending: true)
      .where("users", arrayContains: uid)
      .snapshots()
      .transform(Utils.transformer(Convo.fromJson));

  static Stream<List<User>> getUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .transform(Utils.transformer(User.fromJson));

  static List<String> getChatId(String id_1, String id_2) {
    if (id_1.compareTo(id_2) > 0) {
      return [id_1, id_2];
    } else {
      return [id_2, id_1];
    }
  }

  static Future uploadMessage(String idUser, String message, bool isPic) async {
    var ids = getChatId(idUser, myId);
    String idChat = ids[0] + ids[1];
    DateTime createdAt = DateTime.now();

    final refConvo = FirebaseFirestore.instance.collection('chats').doc(idChat);

    final newMessage = Message(
      type: isPic ? 'image' : 'txt',
      idUser: myId,
      username: myUsername,
      message: message,
      read: false,
      createdAt: createdAt,
    );

    refConvo.set(<String, dynamic>{
      'lastMessage': newMessage.toJson(),
      'users': [idUser, myId],
      'read': false,
      'messageCount': FieldValue.increment(1.0)
    }).then((value) {
      refConvo.collection("messages").add(newMessage.toJson());
    });
  }

  static Future<String> uploadImageToFirebase(
      String idUser, File _imageFile) async {
    String fileName = basename(_imageFile.path);
    var downloadUrl = '';
    var storage = FirebaseStorage.instance;
    TaskSnapshot snapshot =
        await storage.ref('chats/$fileName').putFile(_imageFile);
    if (snapshot.state == TaskState.success) {
      downloadUrl = await snapshot.ref.getDownloadURL();
    }
    return downloadUrl;
    // String link = await uploadTask.snapshot.ref.getDownloadURL.toString();
    // return link;
  }

  static Stream<List<Message>> getMessages(String idUser) {
    var ids = getChatId(idUser, myId);
    String idChat = ids[0] + ids[1];

    final refConvo = FirebaseFirestore.instance.collection('chats').doc(idChat);

    refConvo.update(<String, dynamic>{'read': true, 'messageCount': 0});

    return FirebaseFirestore.instance
        .collection('chats/$idChat/messages')
        .orderBy(MessageField.createdAt, descending: true)
        .snapshots()
        .transform(Utils.transformer(Message.fromJson));
  }

  static Future addRandomUsers(List<User> users) async {
    final refUsers = FirebaseFirestore.instance.collection('users');

    final allUsers = await refUsers.get();
    if (allUsers.size != 0) {
      return;
    } else {
      for (final user in users) {
        final userDoc = refUsers.doc();
        final newUser = user.copyWith(idUser: userDoc.id);
        await userDoc.set(newUser.toJson());
      }
    }
  }
}
