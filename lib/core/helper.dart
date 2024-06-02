import 'package:chatie/core/firebase_helper.dart';
import 'package:chatie/features/auth/presentation/views/login_view.dart';
import 'package:chatie/features/auth/presentation/views/widgets/button.dart';
import 'package:chatie/features/home/data/cubits/user_data_cubit/user_data_cubit.dart';
import 'package:chatie/features/home/data/models/user_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

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

Future<dynamic> signOutDialog(BuildContext context, {required String email}) {
  return showDialog(
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
                // If the email is not null, update the push token to an empty string in Firestore
                await BlocProvider.of<UserDataCubit>(context)
                    .updateT(token: "", email: email);
                await FirebaseHelper().updateStatus(online: false);
                await FirebaseAuth.instance.signOut().then((value) async {
                  FirebaseMessaging.instance.deleteToken();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginView()),
                      (route) => false);
                  showtoast(
                      time: 1,
                      msg: 'You have successfully signed out.',
                      context: context);
                });
              },
              child: const Text(
                "Sign out",
              ),
            )
          ],
        );
      });
}

class MessageTime {
  String format(dynamic lastSeenTimestamp) {
    try {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(
          int.parse(lastSeenTimestamp.toString()));
      final now = DateTime.now();
      final difference = now.difference(dateTime).inDays; // Difference in days
      String formattedDay;

      if (difference == 0) {
        formattedDay = '';
      } else if (difference == 1) {
        formattedDay = 'Yesterday';
      } else if (difference <= 7) {
        formattedDay = DateFormat('EEEE').format(dateTime);
      } else {
        formattedDay =
            DateFormat('yy/MM/dd').format(dateTime); // Day of the week
      }

      final formattedTime = DateFormat('hh:mm a').format(dateTime);
      return '$formattedDay $formattedTime';
    } catch (e) {
      return 'Unknown';
    }
  }
}
