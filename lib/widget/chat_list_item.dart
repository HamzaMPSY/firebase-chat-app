import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_example/data.dart';
import 'package:firebase_chat_example/model/user.dart';
import 'package:firebase_chat_example/page/chat_page.dart';
import 'package:firebase_chat_example/static/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChatListItem extends StatelessWidget {
  final User user;
  final Map<dynamic, dynamic> lastMessage;

  bool read;
  BuildContext context;

  ChatListItem({Key key, @required this.user, @required this.lastMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (lastMessage['idFrom'] == myId) {
      read = false;
    } else {
      read = lastMessage['read'] == null ? true : lastMessage['read'];
    }
    this.context = context;

    return Container(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      buildContent(context),
    ]));
  }

  buildContent(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChatPage(user: user),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: buildChatDetails(user.name, context),
                  )
                ],
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }

  buildChatDetails(String name, BuildContext context) {
    // return ListTile(
    //   leading: CircleAvatar(
    //     radius: 30,
    //     backgroundImage: NetworkImage(user.urlAvatar),
    //   ),
    //   title: Text(user.name),
    //   subtitle: Text(lastMessage['message'] ?? "Say Hi!"),

    // );

    return Row(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: SizedBox(
                height: 70,
                width: 70,
                child: Stack(
                  fit: StackFit.expand,
                  overflow: Overflow.visible,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.urlAvatar),
                    ),
                    Positioned(
                        bottom: -10,
                        right: -15,
                        child: SizedBox(
                            height: 46,
                            width: 46,
                            child: read
                                ? Container()
                                : Icon(Icons.brightness_1,
                                    color: AppColor.FOCUS_INPUT_COLOR,
                                    size: 20)))
                  ],
                ))),
      ]),
      Column(children: <Widget>[
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              user.name,
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.sulphurPoint(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ]),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: Text(
              lastMessage['message'],
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.sulphurPoint(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ])
      ]),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              getTime(lastMessage['createdAt']),
              textAlign: TextAlign.right,
            ),
          )
        ],
      )
    ]);
  }

  String getTime(Timestamp timestamp) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    DateFormat format;
    if (date.difference(DateTime.now()).inMilliseconds <= 86400000) {
      format = DateFormat('jm');
    } else {
      format = DateFormat.yMd('en_US');
    }
    return format.format(
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch));
  }
}


// return Container(
//             height: 75,
//             child: ListTile(
//               onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => ChatPage(user: user),
//                 ));
//               },
//               leading: CircleAvatar(
//                 radius: 30,
//                 backgroundImage: NetworkImage(user.urlAvatar),
//               ),
//               title: Text(user.name),
//               //subtitle: Text(user.lastMessageId ?? "Say Hi!"),
//             ),
//           );
