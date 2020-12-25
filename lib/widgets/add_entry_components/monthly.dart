import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data.dart';
import '../../locator.dart';
import '../../provider/add_entry_provider.dart';
import '../c_textformfield.dart';

class Monthly extends StatefulWidget {
  Monthly({Key key}) : super(key: key);

  @override
  _MonthlyState createState() => _MonthlyState();
}

class _MonthlyState extends State<Monthly> {
  var _student = locator<Data>();

  TextEditingController _perMonth = TextEditingController();
  TextEditingController _invoice = TextEditingController();

  double _slider = 1.0;
  @override
  void initState() {
    _perMonth.text = _student.getStudent.belt <= 3
        ? _student.getBranch.belowGreen.toString()
        : _student.getBranch.aboveGreen.toString();
    super.initState();
  }

  @override
  void dispose() {
    _perMonth.dispose();
    _invoice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _entryProvider =
        Provider.of<AddEntryProvider>(context, listen: false);
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: CTextFormField(
            label: "Per month",
            hint: "500",
            keyboardType: TextInputType.number,
            controller: _perMonth,
            onChanged: (value) {
              _entryProvider.monthly(int.parse(value), _slider.toInt());
            },
          ),
        ),
        if (locator<Data>().getBranch.indirectPayment)
          Padding(
            padding:
                const EdgeInsets.only(right: 12.0, left: 12.0, bottom: 12.0),
            child: CTextFormField(
              label: "Invoice",
              hint: "123456",
              controller: _invoice,
              onChanged: (value) => _entryProvider.invoice = value,
            ),
          ),
        Slider(
          label: _slider.round().toString(),
          divisions: 5,
          value: _slider,
          onChanged: (value) {
            setState(() {
              _slider = value;
            });
            _entryProvider.setTotalMonth = value.toInt();
            _entryProvider.monthly(int.parse(_perMonth.text), _slider.toInt());
          },
          min: 1,
          max: 6,
          activeColor: Theme.of(context).accentColor,
          inactiveColor: Theme.of(context).splashColor,
        ),
      ],
    );
  }
}
