import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/chat_user.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;
  const ChatScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //     const SystemUiOverlayStyle(statusBarColor:  Color.fromARGB(255, 148, 231, 225),
    // ));
    // final Size si =MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:Color.fromARGB(255, 148, 231, 225), // Set the desired color here
    ));


    return SafeArea(
      child: Scaffold(
        // backgroundColor:const Color.fromRGBO(66, 66,66, 1),
        // backgroundColor:  Color(0xFFCAF0F8),
        backgroundColor: Colors.white,
        appBar: AppBar(
          // backgroundColor:const  Color.fromRGBO(48, 48, 48, 1),
          backgroundColor: Color.fromARGB(255, 148, 231, 225),

          automaticallyImplyLeading: false,
          flexibleSpace: _appbar(),
        ),
        body: Column(
         
          children: [
            Expanded(child: Text("HI")),
            _chatInput()
          ],
        ),
      ),
    );
  }

  Widget _appbar() {
    final Size si = MediaQuery.of(context).size;

    final Shader name_gra = const LinearGradient(
      colors: <Color>[
        Color(0xffDA44bb),
        Color(0xff8921aa)
      ],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    final Shader time_gra = const LinearGradient(
      colors: <Color>[
        Color(0xFF2196F3), // light blue
        Color(0xFF0D47A1), // dark blue
      ],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.white,
            )),
        ClipRRect(
          borderRadius: BorderRadius.circular(si.height),
          child: CachedNetworkImage(
            imageUrl: widget.user.image,
            width: si.height * 0.05,
            height: si.height * 0.05,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.user.name,
                  style: GoogleFonts.josefinSans(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white
                        // foreground: Paint()..shader = name_gra
                    ),
                  )),
              const SizedBox(
                height: 2,
              ),
              Text(
                "This is a time",
                style: GoogleFonts.inconsolata(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        // foreground: Paint()..shader = time_gra
                        color: Colors.grey
                    )),
              )
            ]),
      ],
    );
  }

  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01,
          horizontal: MediaQuery.of(context).size.width * 0.025),
      child: Row(
        children: [
          Expanded(
            child: Card(
              // color: const Color.fromRGBO(48, 48, 48, 1),
              color:  Color(0xFFCAF0F8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  IconButton(
                    splashColor: Colors.yellow,
                      splashRadius: 23,
                      // highlightColor: Colors.transparent,

                      onPressed: () {},
                      icon: const Icon(
                        Icons.emoji_emotions_rounded,
                        color: CupertinoColors.systemGrey2,
                        size: 26,
                      )),
                  const  Expanded(
                      child: TextField(
                        // keyboardType: TextInputType.multiline,
                        // textInputAction: TextInputAction.done,
                        style: TextStyle(color: Colors.white,),


                        // maxLines: null,
                        maxLines: 3,
                        minLines: 1,
                        decoration: InputDecoration(
                        hintText: "Message",
                        hintStyle: TextStyle(fontSize: 20,color: Colors.grey),
                        border: InputBorder.none),
                    // cursorColor: Color.fromRGBO(0, 128, 105, 1),
                        cursorColor:  Color.fromARGB(255, 62, 182, 226),
                  )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.image_outlined,
                        color: CupertinoColors.systemGrey2,
                        size: 26,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.camera_fill,
                        color: CupertinoColors.systemGrey2,
                        size: 26,
                      ))
                ],
              ),
            ),
          ),
          SizedBox(
            width: 45,
            height: 45,
            child: MaterialButton(
              onPressed: () {},
              minWidth: 0,
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 5, left: 10),
              shape: const CircleBorder(),
              // color: const Color.fromRGBO(0, 128, 105, 1),
              // color: const Color.fromRGBO(100,254,218,1),


              color: const Color.fromARGB(255, 62, 182, 226)
              ,
              child: const Icon(
                Icons.send_sharp,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),

          const SizedBox(
            width: 2,
          ),

        ],
      ),
    );
  }
}
