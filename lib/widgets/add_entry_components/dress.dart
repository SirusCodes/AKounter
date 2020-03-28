import 'package:akounter/widgets/c_textformfield.dart';
import 'package:flutter/material.dart';

class Dress extends StatefulWidget {
  const Dress({Key key}) : super(key: key);

  @override
  _DressState createState() => _DressState();
}

class _DressState extends State<Dress> {
  bool _spCheck = false, _vspCheck = false, _vvspCheck = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              fit: FlexFit.loose,
              child: CTextFormField(
                label: "Size",
                hint: "5.09",
              ),
            ),
            SizedBox(width: 10.0),
            Text(
              "Size : **",
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // spcheck
            Row(
              children: [
                Checkbox(
                  value: _spCheck,
                  onChanged: (bool value) {
                    setState(() {
                      _spCheck = value;
                    });
                  },
                ),
                Text("SP")
              ],
            ),
            // vspcheck
            Row(
              children: [
                Checkbox(
                  value: _vspCheck,
                  onChanged: (bool value) {
                    setState(() {
                      _vspCheck = value;
                    });
                  },
                ),
                Text("VSP")
              ],
            ),
            // vvspcheck
            Row(
              children: [
                Checkbox(
                  value: _vvspCheck,
                  onChanged: (bool value) {
                    setState(() {
                      _vvspCheck = value;
                    });
                  },
                ),
                Text("VVSP")
              ],
            )
          ],
        ),
      ],
    );
  }
}
