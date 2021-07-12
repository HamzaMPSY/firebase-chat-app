import 'package:firebase_chat_example/api/firebase_api.dart';
import 'package:firebase_chat_example/model/user.dart';
import 'package:firebase_chat_example/page/chat_page.dart';
import 'package:firebase_chat_example/page/search_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_chat_example/static/AppColor.dart';

typedef void ListCallback(Stream<List<User>> users);

class ChatHeaderWidget extends StatelessWidget {
  final List<User> users;

  const ChatHeaderWidget({
    @required this.users,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Text(
                'Chats',
                style: GoogleFonts.sulphurPoint(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 223, 223, 223),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextFormField(
                  textInputAction: TextInputAction.search,
                  readOnly: true,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SearchPage(
                        users: users,
                      ),
                    ));
                  },
                  cursorColor: AppColor.FOCUS_INPUT_COLOR,
                  decoration: new InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColor.FOCUS_INPUT_COLOR,
                      ),
                      focusColor: AppColor.FOCUS_INPUT_COLOR,
                      fillColor: AppColor.FOCUS_INPUT_COLOR,
                      border: OutlineInputBorder(),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintStyle: GoogleFonts.sulphurPoint(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 8, top: 12, right: 15),
                      hintText: "Rechercher..."),
                ),
              ),
            ),
          ],
        ),
      );
}
