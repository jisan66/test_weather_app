import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message, [Color? bgColor]) {
  Fluttertoast.showToast(
    msg: message.toString(),
    toastLength: Toast.LENGTH_LONG  ,
    gravity: ToastGravity.BOTTOM_LEFT,
    timeInSecForIosWeb: 1,
    backgroundColor: bgColor ?? Colors.purple.withOpacity(.7),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
