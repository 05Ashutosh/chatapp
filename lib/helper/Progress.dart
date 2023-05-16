import 'package:flutter/material.dart';

class Progress{
  static void showProgressBar(BuildContext context){
    showDialog(context: context, builder: (_)=>const Center(child: CircularProgressIndicator()));

  }
}