import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Helper {
  static final Color primaryColor = Color(0xFF323edd);

  static double getResponsiveHeight(double percent, BuildContext context) {
    return percent / 100 * MediaQuery.of(context).size.height;
  }

  static double getResponsiveWidth(double percent, BuildContext context) {
    return percent / 100 * MediaQuery.of(context).size.width;
  }

  // Form validation form fields
  static String checkIfFieldIsEmpty(String value) {
    if (value.isEmpty) {
      return 'Please fill this field';
    }
    return null;
  }

  static String validateEmailAddress(String value) {
    RegExp regExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (!regExp.hasMatch(value)) {
      return 'Please input a valid email address';
    }
    return null;
  }

  static String validatePassword(String value) {
    if (value.length < 8) {
      return 'Password has to be up to 8 characters';
    }
    return null;
  }

  static String validatePhoneNumber(String value) {
    print(value.length);
    if (value.length == 11 || value.length == 13) {
      return null;
    }
    return 'Please input a valid phone number';
  }

  static void displayError(String message, BuildContext context, {int duration = 5}) {
    Flushbar flushBar;
    flushBar = Flushbar(
      message: message,
      backgroundColor: Color(0xffcf6679),
      mainButton: FlatButton(
        onPressed: () {
          flushBar.dismiss([]);
        },
        child: Icon(
          Icons.cancel,
          color: Colors.white,
          size: 20,
        ),
      ),
      flushbarStyle: FlushbarStyle.GROUNDED,
      duration: Duration(seconds: duration),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    )..show(context);
  }

  static void displaySuccess(String message, BuildContext context, {int duration = 5}) {
    Flushbar flushBar;

    flushBar = Flushbar(
      message: message,
      backgroundColor: Colors.greenAccent[400],
      mainButton: FlatButton(
        onPressed: () {
          flushBar.dismiss([]);
        },
        child: Icon(
          Icons.cancel,
          color: Colors.white,
          size: 20,
        ),
      ),
      flushbarStyle: FlushbarStyle.GROUNDED,
      duration: Duration(seconds: duration),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    )..show(context);
  }

  static showPlatformProgressIndicator(BuildContext context) {
    Widget indicator;

    if (Platform.isIOS) {
      indicator = CupertinoActivityIndicator();
    } else if (Platform.isAndroid) {
      indicator = CircularProgressIndicator();
    }

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          child: Container(
            color: Colors.transparent,
            height: 100,
            width: 100,
            child: Center(
              child: indicator,
            ),
          ),
        );
      },
    );
  }

  static Future<bool> showPlatformAlertDialog(BuildContext context, String title, String content,
      String yesActionLabel, String noActionLabel) {
    if (Platform.isIOS) {
      return showCupertinoDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: new Text(title),
            content: new Text(content),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text(yesActionLabel),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              CupertinoDialogAction(
                child: Text(noActionLabel),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              )
            ],
          );
        },
      );
    } else {
      return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(title),
            content: new Text(content),
            actions: <Widget>[
              FlatButton(
                child: Text(yesActionLabel),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              FlatButton(
                child: Text(noActionLabel),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              )
            ],
          );
        },
      );
    }
  }

  static Future<void> showActionDialog(BuildContext context, Function buildModalContent) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10.0,
          backgroundColor: Colors.black.withOpacity(0.2),
          child: buildModalContent(context),
        );
      },
    );
  }

  static dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }

}
