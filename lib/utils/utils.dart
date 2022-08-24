import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static toastMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg, backgroundColor: Colors.black, textColor: Colors.white);
  }

  static flushBarErrorMessage(String msg, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: msg,
          duration: Duration(seconds: 5),
        )..show(context));
  }

  static snackBar(String msg, BuildContext context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}
