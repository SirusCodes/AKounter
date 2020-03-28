import 'package:akounter/widgets/c_textformfield.dart';
import 'package:flutter/material.dart';

class Monthly extends StatefulWidget {
  Monthly({Key key}) : super(key: key);

  @override
  _MonthlyState createState() => _MonthlyState();
}

class _MonthlyState extends State<Monthly> {
  double _slider = 1.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: CTextFormField(
            label: "Per month",
            hint: "500",
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value <= 0) {
                return "Enter a valid Amount";
              }
              return null;
            },
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
