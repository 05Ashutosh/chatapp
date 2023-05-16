import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/API/apis.dart';
import 'package:chatapp/helper/snackbar.dart';
import 'package:chatapp/models/chat_user.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../Utils/colors.dart';
import '../auth/login_screen.dart';
import '../helper/Progress.dart';

import 'dart:developer';

import 'dart:io';

class ProfilePage extends StatefulWidget {
  final ChatUser user;
  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>(); //This store the state of the form

  String? _image; //used for picking gallery

  @override
  Widget build(BuildContext context) {
    Size m = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context)
          .unfocus(), // this help us when we click on the screen the keyboard will hide
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Profile",
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: FloatingActionButton.extended(
              onPressed: () async {
                Progress.showProgressBar(context);
                await FirebaseAuth.instance.signOut();
                await GoogleSignIn().signOut();
                //this is for hiding progress
                // Navigator.pop(context);

                //this stop moving to the home screen
                Navigator.pop(context);
                // Navigator.popUntil(c0LMM9ontext, ModalRoute.withName('/login'));

                Dialogs.showSnackbar(context, "Logout", Colors.red);

                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
              },
              backgroundColor: gr,
              label: const Text('Logout'),
              icon: const Icon(Icons.logout_rounded),
            ),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: m.width * .05),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: m.height * .1,
                    ),
                    Center(
                      child: Column(
                        children: [
                          Stack(children: [
                            // profile picture
                            _image != null
                                ? ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(m.height * 0.1),
                                    child: Image.file(
                                      File(_image!),
                                      fit: BoxFit.cover,
                                      //this property is used to fill the area of ClipRRect
                                      height: m.height * 0.2,
                                      width: m.height * 0.2,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(m.height * 0.1),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover, //this property is used to fill the area of ClipRRect
                                      height: m.height * 0.2,
                                      width: m.height * 0.2,
                                      imageUrl: widget.user.image,
                                      errorWidget: (context, url, error) =>
                                          const CircleAvatar(
                                        child: Icon(CupertinoIcons.person),
                                      ),
                                    ),
                                  ),

                            //Edit picture
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: MaterialButton(
                                    onPressed: () {
                                      _showBottomSheet(context);
                                      SystemChrome.setEnabledSystemUIMode(
                                          SystemUiMode.edgeToEdge);
                                    },
                                    shape: const CircleBorder(),
                                    color: Colors.white,
                                    child: const Icon(
                                      Icons.edit,
                                    )))
                          ]),
                          SizedBox(
                            height: m.height * .02,
                          ),
                          Text(
                            widget.user.email,
                            style: GoogleFonts.robotoMono(
                                textStyle: const TextStyle(
                                    color: Colors.black54, fontSize: 16)),
                          ),
                          SizedBox(
                            height: m.height * .05,
                          ),

                          //Name Text-field
                          TextFormField(
                            initialValue: widget.user.name,
                            onSaved: (val) => APIs.My_Info.name = val ?? '',
                            validator: (val) => val != null && val.isNotEmpty
                                ? null
                                : 'Name Required',
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                CupertinoIcons.person,
                                color: Colors.greenAccent,
                              ),
                              hintText: 'eg. +${widget.user.name}',
                              label: const Text('User'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                          SizedBox(
                            height: m.height * .03,
                          ),

                          //About text-field
                          TextFormField(
                            initialValue: widget.user.about,
                            onSaved: (val) => APIs.My_Info.about = val ?? '',
                            validator: (val) => val != null && val.isNotEmpty
                                ? null
                                : 'About Required',
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.abc_outlined,
                                color: Colors.greenAccent,
                              ),
                              hintText: 'eg. ${widget.user.about}',
                              label: const Text('About'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                          SizedBox(
                            height: m.height * .03,
                          ),

                          //save button
                          ElevatedButton.icon(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                log('Validate data${_formKey.currentState}');
                                _formKey.currentState!.save();
                                APIs.updateUserInfo();
                                Dialogs.showSnackbar(
                                    context, "Updated", Colors.green);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => HomeScreen()));
                              }
                            },
                            icon: const Icon(Icons.save),
                            label: const Text(
                              "Save",
                              style: TextStyle(fontSize: 17),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                elevation: 1,
                                shape: const StadiumBorder(),
                                minimumSize:
                                    Size(m.width * 0.4, m.height * 0.055)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void _showBottomSheet(BuildContext context) {
    // this is here to hide the nav bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) => Padding(
        // padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        padding: EdgeInsets.only(
          top: 16.0,
          left: 16.0,
          right: 16.0,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50.0,
        ),

        // padding: EdgeInsets.only(top: 16.0, left: 16.0,right: 16.0, bottom: 80),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Pick Profile Picture",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    // Pick an image.
                    final XFile? image = await picker.pickImage(
                        source: ImageSource.camera,
                        imageQuality: 70
                    );
                    if (image != null) {
                      log('Image Path:${image.path} ');
                      setState(() {
                        _image = image.path;
                      });

                      // calling the updateProfile Picture to update the profile image in the database
                      APIs.updateProfilePicture(File(_image!));

                      //Hiding the showModalBottomSheet
                      Navigator.pop(context);
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        10.0), // change the value as needed
                    child: Image(
                      image: AssetImage('images/cam.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Image(
                  //   image: AssetImage('images/cam.jpg'),
                  //
                  //   fit: BoxFit.cover,
                  // ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.25,
                          MediaQuery.of(context).size.width * 0.25),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  // shape: const  CircleBorder()),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    // Pick an image.
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery,
                         imageQuality: 70
                        );
                    if (image != null) {
                      log('Image Path:${image.path} --MineType: ${image.mimeType}');
                      setState(() {
                        _image = image.path;
                      });

                      // calling the updateProfile Picture to update the profile image in the database
                      APIs.updateProfilePicture(File(_image!));

                      //Hiding the showModalBottomSheet
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.25,
                          MediaQuery.of(context).size.width * 0.25),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Image(
                    image: AssetImage('images/gallery.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//rough
// void _showBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     builder: (context) => SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 20.0),
//         child: Container(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'This is a Modal bottom sheet!',
//                 style: Theme.of(context).textTheme.headline4,
//                 textAlign: TextAlign.center,
//               ),
//               ElevatedButton(
//                 child: const Text('Close BottomSheet'),
//                 onPressed: () => Navigator.pop(context),
//               )
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
//bottom sheet for picking a profile picture for user
//   void _showBottomSheet(BuildContext context) {
//     showBottomSheet(context: context, shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),  builder: (_){
//       return
// ListView(
//   padding: EdgeInsets.only(top: mq.height * 0.3,bottom: mq.height*0.5),
//   shrinkWrap: true,
//   children: [
//     Text("Pick Profile Picture",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
//
//     SizedBox(height: mq.height*0.02,),
//
//     Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         ElevatedButton(onPressed: (){}, child: Icon(CupertinoIcons.photo),style: ElevatedButton.styleFrom(backgroundColor: Colors.white,fixedSize: Size(mq.width*0.3,mq.height*0.15),shape: CircleBorder()),),
//         ElevatedButton(onPressed: (){}, child: Icon(Icons.camera),style: ElevatedButton.styleFrom(backgroundColor: Colors.white,fixedSize: Size(mq.width*0.3,mq.height*0.15),shape: CircleBorder()),)
//
//       ],)
//   ],
// );

//   });
// }

// void _showBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
//     ),
//     builder: (context) =>
//         ListView(
//           padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3,bottom:MediaQuery.of(context).size.height*0.5),
//           shrinkWrap: true,
//           children: [
//             Text("Pick Profile Picture",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
//
//             SizedBox(height: MediaQuery.of(context).size.height *0.02,),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(onPressed: (){}, child: Icon(CupertinoIcons.photo),style: ElevatedButton.styleFrom(backgroundColor: Colors.white,fixedSize: Size(MediaQuery.of(context).size.width*0.3,MediaQuery.of(context).size.height*0.15),shape: CircleBorder()),),
//                 ElevatedButton(onPressed: (){}, child: Icon(Icons.camera),style: ElevatedButton.styleFrom(backgroundColor: Colors.white,fixedSize: Size(MediaQuery.of(context).size.width*0.3,MediaQuery.of(context).size.height*0.15),shape: CircleBorder()),)
//
//               ],)
//           ],
//         ),
//   );
// }
