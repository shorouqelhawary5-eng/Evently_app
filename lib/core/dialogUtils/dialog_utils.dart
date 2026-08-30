import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogUtils {
  static void showLoading(BuildContext context, bool dismissible) {
    showDialog(
      barrierDismissible: dismissible,
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [CircularProgressIndicator()],
        ),
      ),
    );
  }

  static void hideShowDialog(BuildContext context) {
    Navigator.pop(context, RoutesManager.register);
  }

  static void showToastMessage(String message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
