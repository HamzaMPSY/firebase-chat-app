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

  final bool read;
  final int messageCount;
  BuildContext context;

  ChatListItem(
      {Key key, this.user, this.lastMessage, this.messageCount, this.read})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (lastMessage['idUser'] == myId) {
    //   read = false;
    // }
    print(read);
    print(messageCount);
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
                    width: MediaQuery.of(context).size.width * 0.9,
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
    return Container(
      height: 60,
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatPage(user: user),
          ));
        },
        leading: Container(
            height: 50,
            width: 50,
            child: Center(
              child: Stack(
                fit: StackFit.expand,
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
                                  size: 20))),
                  Positioned(
                      bottom: -23,
                      right: -35,
                      child: SizedBox(
                          height: 46,
                          width: 46,
                          child: read
                              ? Container()
                              : Container(
                                  child: Text(
                                  messageCount.toString(),
                                  style: GoogleFonts.sulphurPoint(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))))
                ],
              ),
            )),
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(user.name,
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: GoogleFonts.sulphurPoint(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              )),
        ),
        subtitle: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Flexible(
                        child: Text(
                          lastMessage['message'],
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: GoogleFonts.sulphurPoint(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    getTime(lastMessage['createdAt']),
                    textAlign: TextAlign.right,
                    style: GoogleFonts.sulphurPoint(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String getTime(Timestamp timestamp) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
    DateFormat format;
    if (DateTime.now().difference(date).inDays <= 1) {
      format = DateFormat('jm');
    } else {
      format = DateFormat.yMd('fr_FR');
    }
    return format.format(
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch));
  }
}
