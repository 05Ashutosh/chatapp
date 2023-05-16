import 'dart:async';
import 'dart:io';


import 'package:chatapp/API/apis.dart';
import 'package:chatapp/Utils/colors.dart';
import 'package:chatapp/helper/Progress.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../helper/snackbar.dart';


import 'dart:developer' as developer;


//Global object for accessing device screen size
late Size mq;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isVisible = false;




  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _isVisible = true;
      });
    });
  }
  
  
  _handleGoogleBtnClick(){
    //for showing pro
    Progress.showProgressBar(context);
    _signInWithGoogle().then((user) async {
      Navigator.pop(context);
      if(user!=null){
        developer.log('\nuser:${user.user}');
        developer.log('\nUserAdditionalInfo:${user.additionalUserInfo}');
        if(await APIs.userExists()){
          Dialogs.showSnackbar(context, "Success", Colors.green);
          Navigator.push(context, MaterialPageRoute(builder: (_)=>const HomeScreen()));
        }
        else{
          await APIs.createUser().then((value) {
          Dialogs.showSnackbar(context, "Success", Colors.green);
              Navigator.push(context, MaterialPageRoute(builder: (_)=>const HomeScreen()));
          });
        }

      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {    // ? is there to tell it is future method so it will return null
      try{
        await InternetAddress.lookup('Google.com');
        // Trigger the authentication flow
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Once signed in, return the UserCredential
        return await APIs.auth.signInWithCredential(credential);
      }
      catch(e){
        print('\n_signInWithGoogle: $e');
        Dialogs.showSnackbar(context, "No Internet",Colors.red);
        return null;
      }
  }


  // // sign out function
  // _signOut()async{
  //   await FirebaseAuth.instance.signOut();
  //   or  await APIs.auth.signOut();
  //   await GoogleSignIn().signOut();
  // }
  
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Welcome Dev Chat",),
        backgroundColor: gButton,
      ),
      body: Stack(
        children: [
          Positioned(
              left: mq.width * .25,
              top: mq.height * .15,
              width: mq.width * .50,
              child:

              AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Image.asset('images/code.png'),
              ),
              // Image.asset('images/code.png')
          ),
          
          //Google Login Button
          Positioned(
              left: mq.width * .15,
              bottom: mq.height * .2,
              width: mq.width * .7,
              height: mq.height * .05,
              child: ElevatedButton.icon(
                onPressed: () {
                  _handleGoogleBtnClick();
                },
                icon: Image.asset(
                  "images/google.png",height: mq.height * 0.045,
                ),
                label: RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                        text: "Sign-in With ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14)),
                    TextSpan(
                        text: "Google",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16))
                  ]),
                ),
                // Text("Sign with Google"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: boys, shape:const StadiumBorder()),
              ))
        ],
      ),
    );
  }
}


