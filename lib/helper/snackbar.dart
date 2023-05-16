import 'package:chatapp/Utils/colors.dart';
import 'package:flutter/material.dart';

class Dialogs{
  static void showSnackbar(BuildContext context,String msg,Color col){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg),backgroundColor: col,));
  }
}