import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

///SHOWS A TOAST MESSAGE
showToast(String message, ToastGravity gravity) {
  return Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.blue,
    gravity: gravity,
    textColor: Colors.white,
    fontSize: 15,
    toastLength: Toast.LENGTH_SHORT,
  );
}

