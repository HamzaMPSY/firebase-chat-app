import 'package:firebase_chat_example/model/user.dart';
import 'package:firebase_chat_example/page/chat_page.dart';
import 'package:firebase_chat_example/static/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  final List<User> users;
  const SearchPage({Key key, this.users}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState(users);
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  List<User> searchList = [];

  List<User> users;
  _SearchPageState(this.users);

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.text.isEmpty) {
        setState(() {
          searchList = users;
        });
      } else {
        setState(() {
          String s = controller.text;
          searchList = users
              .where((element) =>
                  element.name.toLowerCase().contains(s.toLowerCase()))
              .toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget buildChats() => ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final user = searchList[index];

            return Container(
              height: 75,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChatPage(user: user),
                  ));
                },
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(user.urlAvatar),
                ),
                title: Text(user.name),
              ),
            );
          },
          itemCount: searchList.length,
        );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: AppColor.FOCUS_INPUT_COLOR,
        ),
        backgroundColor: Colors.white,
        title: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Text(
            'Rechercher',
            style: GoogleFonts.sulphurPoint(
              color: Colors.black,
              fontSize: 35,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 223, 223, 223),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: TextFormField(
                  textInputAction: TextInputAction.search,
                  cursorColor: AppColor.FOCUS_INPUT_COLOR,
                  controller: controller,
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
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: buildChats(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
