import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showtoast({required String msg, required BuildContext context}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
  );
}
