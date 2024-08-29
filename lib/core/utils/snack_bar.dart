import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';

import 'package:flutter/material.dart';

class SnackBarUtils {
  static void showFlushBarSuccess(BuildContext context, String message) {
    Flushbar(
      message: message,
      backgroundColor: Colors.green,
      icon: const Icon(
        Icons.check_circle,
        color: Colors.white,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      margin: const EdgeInsets.all(8.0),
      flushbarPosition: FlushbarPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  static void showFlushBarFailure(BuildContext context, String message) {
    Flushbar(
      message: message,
      backgroundColor: Colors.red,
      icon: const Icon(
        Icons.error,
        color: Colors.white,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      margin: const EdgeInsets.all(8.0),
      flushbarPosition: FlushbarPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  static void showFlushBarIntemediate(BuildContext context, String message) {
    Flushbar(
      message: message,
      backgroundColor: const Color.fromARGB(255, 148, 148, 148),
      icon: const Icon(
        Icons.info,
        color: Colors.white,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      margin: const EdgeInsets.all(8.0),
      flushbarPosition: FlushbarPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  static void showFlushBar(BuildContext context, String message) {
    FlushbarHelper.createSuccess(
      message: message,
      // backgroundColor: Colors.red,
      // borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      // margin: const EdgeInsets.all(8.0),
      // flushbarPosition: FlushbarPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    ).show(context);
  }
}
