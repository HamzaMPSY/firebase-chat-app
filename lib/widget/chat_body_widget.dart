import 'package:firebase_chat_example/api/firebase_api.dart';
import 'package:firebase_chat_example/data.dart';
import 'package:firebase_chat_example/model/message.dart';
import 'package:firebase_chat_example/model/user.dart';
import 'package:firebase_chat_example/page/chat_page.dart';
import 'package:firebase_chat_example/widget/chat_list_item.dart';
import 'package:flutter/material.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<User> users;
  List<Convo> convos;

  ChatBodyWidget({
    @required this.users,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: StreamBuilder<List<Convo>>(
            stream: FirebaseApi.getConvos(myId),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return buildText('Something Went Wrong Try later');
                  } else {
                    convos = snapshot.data;
                    return Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      //child: buildChats(),
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: getWidgets(),
                      ),
                    );
                  }
              }
            }),
      );

  List<Widget> getWidgets() {
    final List<Widget> list = <Widget>[];
    Map<String, User> userMap = getUserMap(users);
    for (Convo c in convos) {
      if (c.userIds[0] == myId) {
        list.add(ChatListItem(
            user: userMap[c.userIds[1]],
            lastMessage: c.lastMessage,
            read: c.read,
            messageCount: c.messageCount));
      } else {
        print("here${c.messageCount}");

        list.add(ChatListItem(
            user: userMap[c.userIds[0]],
            lastMessage: c.lastMessage,
            read: c.read,
            messageCount: c.messageCount));
      }
    }
    return list;
  }
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );

Map<String, User> getUserMap(List<User> users) {
  final Map<String, User> userMap = Map();
  for (User u in users) {
    userMap[u.idUser] = u;
  }
  return userMap;
}
