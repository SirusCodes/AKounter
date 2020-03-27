import 'package:flutter/material.dart';

class AddEntry extends StatefulWidget {
  AddEntry({Key key}) : super(key: key);

  @override
  _AddEntryState createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Add Entry"),
      ),
      body: SizedBox.expand(
        child: Container(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
