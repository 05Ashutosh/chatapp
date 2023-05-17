import 'package:chatapp/screens/profile.dart';
import 'package:chatapp/widgets/chat_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../API/apis.dart';
import '../Utils/colors.dart';
import '../main.dart';
import '../models/chat_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //for storing all users
  List<ChatUser> _list = [];

  //for storing searched items
  final List<ChatUser> _searchList = [];

  //for storing search status
  bool _isSearching = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    APIs.getselfinfo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchList.clear();
  }

  @override
  Widget build(BuildContext context) {
    //Global object for accessing device screen size
    mq = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context)
          .unfocus(), //this is used to focus ofn the screen to keyboard hide
      child: WillPopScope(
        //if the search is on & back button is pressed then close search
        //or else close current screen on back button click

        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          // appBar
          appBar: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 10,
            backgroundColor: Color.fromARGB(255, 148, 231, 225),
            // leading: const Icon(
            //   Icons.home,
            //   color: Colors.white,
            //   size: 30,
            // ),
            centerTitle: false,
            title:
                _isSearching
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        decoration: const BoxDecoration(
                          // color: Color.fromARGB(255, 148, 231, 205),
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: TextField(
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: "Name Email .."),
                          cursorColor:  Color.fromARGB(255, 62, 182, 226),
                          autofocus: true, //this will make sure that the cursor is there when we click the lens sign
                          style: const TextStyle(fontSize: 17, letterSpacing: 0.5),
                          onChanged: (val) {
                            // search logic
                            _searchList.clear();

                            for (var i in _list) {
                              if (i.name
                                      .toLowerCase()
                                      .contains(val.toLowerCase()) ||
                                  i.email
                                      .toLowerCase()
                                      .contains(val.toLowerCase())) {
                                _searchList.add(i);
                                // setState(() {
                                //   _searchList;
                                // }); more efficient
                              }
                            }
                            setState(() {
                              _searchList;
                            });
                          },
                        ),
                      )

              : Text(" Fusion",
                        style: GoogleFonts.kalam(
                            textStyle:const TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w600)),
                      ),

            actions: [
              //search userButton
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                    });
                  },
                  icon: Icon(
                    _isSearching ? CupertinoIcons.clear_thick : Icons.search,
                    size: 30,
                    color: Colors.white,
                  )),

              //  profile button

              //more feature button
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProfilePage(
                                  user: APIs.My_Info,
                                )));
                  },
                  icon: const Icon(
                    Icons.menu,
                    size: 30,
                    color: Colors.white,
                  )),
            ],
          ),

          //floating button to add new user
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: FloatingActionButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await GoogleSignIn().signOut();
              },
              backgroundColor: gr,
              child: const Icon(Icons.add_comment_rounded),
            ),
          ),

          body: StreamBuilder(
              stream: APIs
                  .getAllUsers(), //we have to where we want to excess the data
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  // if data is loading
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(child: CircularProgressIndicator());
                  //  if some or all data is loaded then show it
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs;
                    _list = data
                            ?.map((e) => ChatUser.fromJson(e.data()))
                            .toList() ??
                        [];

                    if (_list.isNotEmpty) {
                      return ListView.builder(
                          padding: EdgeInsets.only(top: mq.height * 0.01),
                          physics: const BouncingScrollPhysics(),
                          itemCount:
                              _isSearching ? _searchList.length : _list.length,
                          itemBuilder: (context, index) {
                            return ChatCard(
                              index: index,
                              user: _isSearching
                                  ? _searchList[index]
                                  : _list[index],
                            );
                            // return Text("Name: ${list[index]}");
                          });
                    } else {
                      return const Center(
                          child: Text(
                        "No Connection are found",
                        style: TextStyle(fontSize: 20),
                      ));
                    }
                }
              }),
        ),
      ),
    );
  }



}



// Widget _appbar() {
//
//   return AppBar(
//     automaticallyImplyLeading: false,
//     leading:  const Icon(
//       Icons.home,
//       color: Colors.white,
//       size: 30,
//     ),
//     titleSpacing: 0,
//     title: Row(
//       children: [
//
//       ],
//     ),
//
//   )
// }