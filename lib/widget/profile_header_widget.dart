import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final String urlAvatar;

  const ProfileHeaderWidget({
    @required this.name,
    @required this.urlAvatar,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: 70,
        padding: EdgeInsets.only(left: 10, top: 6, right: 10),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(color: Colors.black),
                Expanded(
                  child: Text(
                    name,
                    style: GoogleFonts.sulphurPoint(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconTheme(
                      data: new IconThemeData(
                          color: Colors.pink.shade200, size: 25),
                      child: new Icon(Icons.call),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    IconTheme(
                      data: new IconThemeData(
                          color: Colors.pink.shade200, size: 25),
                      child: new Icon(Icons.videocam_sharp),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(urlAvatar),
                    ),
                  ],
                ),
                SizedBox(width: 4),
              ],
            )
          ],
        ),
      );

  // Widget buildIcon(IconData icon) => Container(
  //       padding: EdgeInsets.all(5),
  //       decoration: BoxDecoration(
  //         shape: BoxShape.circle,
  //         color: Colors.white54,
  //       ),
  //       child: Icon(icon, size: 25, color: Colors.white),
  //     );
}
