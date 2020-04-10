import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Widget cSnackBar(BuildContext context, {String message, FlatButton button}) {
  return Flushbar(
    message: message,
    margin: EdgeInsets.all(8.0),
    borderRadius: 8,
    duration: Duration(seconds: 2),
    mainButton: button,
  )..show(context);
}
