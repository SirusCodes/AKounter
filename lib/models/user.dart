import 'package:flutter/material.dart';

@immutable
class User {
  const User({@required this.uid, @required this.displayName});
  final String uid;
  final String displayName;
}
