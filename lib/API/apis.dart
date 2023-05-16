import 'dart:developer';

import 'package:chatapp/models/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class APIs {

  //for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //for accessing cloud firebase database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  //for storing self information
  static late ChatUser My_Info;

  //for accessing firebase storage
  static FirebaseStorage storage =FirebaseStorage.instance;


  //to return the current user
  static User get user => auth.currentUser!;

 // for checking if the user exists or not?
  static Future<bool> userExists() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  //  getting user info
  static Future<void> getselfinfo() async {
    await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get().then((user) async {
              if(user.exists){
                // My_Info=user.data() as ChatUser;
                My_Info = ChatUser.fromJson(user.data()!);
              }
              else{
                await createUser().then((value) => getselfinfo());
              }
    });

  }

//   static Stream<QuerySnapshot<Map<String, dynamic>>> getselfinfo async{
//     return
// }

// for creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUser(
        image: user.photoURL.toString(),
        name: user.displayName.toString(),
        about: "Hey IS a Dec Chat",
        createdAt: time,
        lastActive: time,
        isOnline: false,
        id: user.uid,
        pushToken: '',
        email: user.email.toString());
    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }


  //getting all users information from the firestore database
  static Stream<QuerySnapshot<Map<String,dynamic>>> getAllUsers(){
    // return firestore.collection('users').snapshots(); this shows all users data including ours information
    return firestore.collection('users').where('id', isNotEqualTo:user.uid).snapshots();

  }

  static Future<void> updateUserInfo() async{
    // there are who data set and update both are different
    await firestore.collection('users')..doc(user.uid).update({'name':My_Info.name,'about':My_Info.about});
  }

  static Future<void> updateProfilePicture(File file)async {
    //for getting exe
    final ext=file.path.split('.').last;
    //storage file ref with path
    final ref = storage.ref().child('profile_Picture/${user.uid}.$ext');

    //uploading image
    await ref.putFile(file,SettableMetadata(contentType: 'image/$ext')).then((p0){
      log('Data Transferred :${p0.bytesTransferred/1000} KB');
    });

    // getting the download url / for updating image in firestore database
    My_Info.image=await ref.getDownloadURL();

    await firestore.collection('users')..doc(user.uid).update({'image':My_Info.image,'about':My_Info.about});

  }
}
