import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/models/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/colors.dart';
import '../main.dart';
import '../screens/ChatScreen.dart';

// class ChatCard extends StatefulWidget {
//   const ChatCard({Key? key}) : super(key: key);
//
//   @override
//   State<ChatCard> createState() => _ChatCardState();
// }
//
// class _ChatCardState extends State<ChatCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       elevation: 1.5,
//       margin: EdgeInsets.symmetric(horizontal: mq.width*0.04,vertical: 4),
//         color: Colors.red,
//         child: InkWell(
//           onTap: () {},
//           child: const ListTile(
//
//             //User profile picture
//             leading: CircleAvatar(
//               child: Icon(CupertinoIcons.person),
//             ),
//
//             //User name
//             title: Text("Demo User"),
//
//             //last message
//             subtitle: Text(
//               "Last user Message",
//               maxLines: 1,
//             ),
//
//             //Last message time
//             trailing: Text(
//               "12:00Pm",
//               style: TextStyle(color: re),
//             ),
//           ),
//         ));
//   }
// }
class ChatCard extends StatefulWidget {
  final int index;
  final ChatUser user;

  const ChatCard({Key? key, required this.index, required this.user})
      : super(key: key);

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  // Create an array of colors that you want to use for each card
  final List<Color> cardColors = [
    Color(0xFFBDE0FE),
    Color(0xFFEDEDE9),
    Color(0xFFCAF0F8), // Add the new colors to the list
    Color(0xFFD8F3DC),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 1.5,
        margin: EdgeInsets.symmetric(horizontal: mq.width * 0.04, vertical: 4),
        color: cardColors[widget.index %
            cardColors.length], // Get the color for the current card
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(user: widget.user,)));
          },
          child: ListTile(
            //User profile picture
            leading:
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                height: mq.height*0.055,
                width: mq.height*0.055,
                fit: BoxFit.cover,
                imageUrl: widget.user.image,
                // placeholder: (context, url) => const CircularProgressIndicator(), //for when we want to indicator when is image is not loaded
                errorWidget: (context, url, error) => const CircleAvatar(
                  child: Icon(CupertinoIcons.person),
                ),
              ),
            ),

            //User name
            title: Text(widget.user.name),

            //last message
            subtitle: Text(
              widget.user.about,
              maxLines: 1,
            ),

            //Last message time
            // trailing: Text(
            //   "12:00Pm",
            //   style: TextStyle(color: re),
            // ),
            trailing:Container(height: 7,width: 7
            ,decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                  color: Colors.white

              ),)
          ),
        ));
  }
}
