import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget errorContainer(Function onPressed, String message){
  return Container(child: Center(
    child: TextButton(
        onPressed: (){onPressed;},
        child: Text(message)),),);
}