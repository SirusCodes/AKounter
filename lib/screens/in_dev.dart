import 'package:flutter/material.dart';

class InDevelopment extends StatelessWidget {
  const InDevelopment({Key key, this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text(text)),
    );
  }
}
