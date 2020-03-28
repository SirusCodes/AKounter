import 'package:akounter/widgets/c_textformfield.dart';
import 'package:flutter/material.dart';

class Others extends StatefulWidget {
  Others({Key key}) : super(key: key);

  @override
  _OthersState createState() => _OthersState();
}

class _OthersState extends State<Others> {
  var _topPadding = const EdgeInsets.only(top: 8.0);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            CTextFormField(label: "Reason"),
            Padding(
              padding: _topPadding,
              child: CTextFormField(
                label: "Amount",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
