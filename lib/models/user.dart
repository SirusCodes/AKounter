import 'package:flutter/material.dart';

@immutable
class User {
  const User({
    @required this.uid,
    @required this.displayName,
    @required this.mailID,
  });
  final String uid;
  final String displayName;
  final String mailID;
}
