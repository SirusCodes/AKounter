import 'package:akounter/provider/add_entry_provider.dart';
import 'package:akounter/widgets/c_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        child: Consumer<AddEntryProvider>(
          builder: (_, _entry, __) {
            return Column(
              children: [
                CTextFormField(
                  label: "Reason",
                  onChanged: (value) {
                    _entry.setDetailedReason = value;
                  },
                ),
                Padding(
                  padding: _topPadding,
                  child: CTextFormField(
                    label: "Amount",
                    keyboardType: TextInputType.number,
                    onChanged: (value) => _entry.setSubtotal = int.parse(value),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
