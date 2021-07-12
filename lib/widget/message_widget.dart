import 'package:firebase_chat_example/model/message.dart';
import 'package:firebase_chat_example/static/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final bool isMe;

  const MessageWidget({
    @required this.message,
    @required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(10);
    final borderRadius = BorderRadius.all(radius);

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        // if (!isMe)
        //   CircleAvatar(
        //       radius: 16, backgroundImage: NetworkImage(message.urlAvatar)),
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(8),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          decoration: isMe
              ? BoxDecoration(
                  // color: isMe ? Colors.grey[100] : Theme.of(context).accentColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColor.FOCUS_INPUT_COLOR,
                      AppColor.GRIDIENT_COLOR,
                    ],
                  ),
                  borderRadius: borderRadius
                      .subtract(BorderRadius.only(bottomRight: radius)))
              : BoxDecoration(
                  color: AppColor.RECIVED_CHAT_COLOR,
                  borderRadius: borderRadius
                      .subtract(BorderRadius.only(bottomLeft: radius)),
                ),
          child: buildMessage(),
        ),
      ],
    );
  }

  Widget buildMessage() => Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.message,
            style: GoogleFonts.sulphurPoint(
              color: Colors.black,
            ),
            textAlign: isMe ? TextAlign.start : TextAlign.start,
          ),
        ],
      );
}
