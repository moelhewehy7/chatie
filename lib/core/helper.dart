import 'package:chatie/features/auth/presentation/views/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showtoast(
    {required String msg, required BuildContext context, required int time}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: time,
  );
}

showAlert(
  BuildContext context, {
  required String title,
  required String content,
  required String buttonText,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          title,
        ),
        content: Text(
          content,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          FillButton(
              height: 30,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(buttonText)),
        ],
      );
    },
  );
}

void signoutdialog(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text(
            "Are you sure you want to sign out",
          ),
          actions: [
            FilledTonalButton(
              height: 30,
              onPressed: () {
                Navigator.pop(context);
              },
              text: "Cancel",
            ),
            FillButton(
              height: 30,
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (context.mounted) {
                  Navigator.pop(context);
                  showtoast(
                      time: 1,
                      msg: 'You have successfully signed out.',
                      context: context);
                }
              },
              child: const Text(
                "Sign out",
              ),
            )
          ],
        );
      });
}
