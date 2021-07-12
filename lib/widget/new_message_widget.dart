import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_example/api/firebase_api.dart';
import 'package:firebase_chat_example/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class NewMessageWidget extends StatefulWidget {
  final String idUser;

  const NewMessageWidget({
    @required this.idUser,
    Key key,
  }) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  String message = '';

  void sendMessage() async {
    FocusScope.of(context).unfocus();

    await FirebaseApi.uploadMessage(widget.idUser, message, false);

    _controller.clear();
  }

  final picker = ImagePicker();
  File _imageFile;

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() async {
      _imageFile = File(pickedFile.path);
      String filename =
          await FirebaseApi.uploadImageToFirebase(widget.idUser, _imageFile);

      FirebaseApi.uploadMessage(
          widget.idUser,
          filename,
          // 'https://firebasestorage.googleapis.com/v0/b/chatapp-d1409.appspot.com/o/$filename?alt=media&token=abd38181-cbd8-473e-862d-80ae1b9b9f07',
          true);
    });
  }

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.grey[100],
        padding: EdgeInsets.all(5),
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: pickImage,
              child: IconTheme(
                data: new IconThemeData(color: Colors.black26, size: 30),
                child: new Icon(Icons.camera_alt_rounded),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _controller,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Taper message...',
                  labelStyle: GoogleFonts.sulphurPoint(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0),
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) => setState(() {
                  message = value;
                }),
              ),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: message.trim().isEmpty ? null : sendMessage,
              child: Container(
                padding: EdgeInsets.all(8),
                // decoration: BoxDecoration(
                //   shape: BoxShape.circle,
                //   color: Colors.white,
                // ),
                child: Icon(Icons.send, color: Colors.black26),
              ),
            ),
          ],
        ),
      );
}
