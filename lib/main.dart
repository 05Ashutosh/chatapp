// firebase
import 'package:chatapp/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

import 'package:chatapp/auth/login_screen.dart';
import 'package:flutter/material.dart';

//Colors
import 'Utils/colors.dart';

//Global object for accessing device screen size
late Size mq;

void main()  {
  WidgetsFlutterBinding.ensureInitialized(); // add this line


  _initializeFireBase();



  //Enter to a full-screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  //Orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((value) =>
      null); // this then help us when this function is executed then the code move

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dev Chat',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: p),
            centerTitle: true,
            elevation: 3,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 19,
            ),
            backgroundColor: Colors.white),
      ),
      home: const SplashScreen(),
    );
  }
}

_initializeFireBase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
