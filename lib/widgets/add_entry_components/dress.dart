import 'package:akounter/provider/add_entry_provider.dart';
import 'package:akounter/widgets/c_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../enums/dress_size_enum.dart';

class Dress extends StatefulWidget {
  const Dress({Key key}) : super(key: key);

  @override
  _DressState createState() => _DressState();
}

class _DressState extends State<Dress> {
  DressSP _dress = DressSP.none;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<AddEntryProvider>(
        builder: (_, _entry, __) {
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.loose,
                    child: CTextFormField(
                      label: "Height",
                      hint: "5.09",
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _entry.setSize = int.parse(value);
                      },
                    ),
                  ),
                  SizedBox(width: 10.0),
                  // Text(
                  //   "Size : **",
                  //   style: Theme.of(context).textTheme.display1,
                  // ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // none
                  Row(
                    children: <Widget>[
                      Radio(
                        value: DressSP.none,
                        groupValue: _dress,
                        onChanged: (DressSP value) {
                          setState(() => _dress = value);
                          _entry.setSP = value;
                        },
                      ),
                      Text(
                        "None",
                      ),
                    ],
                  ),
                  // spcheck
                  Row(
                    children: <Widget>[
                      Radio(
                        value: DressSP.sp,
                        groupValue: _dress,
                        onChanged: (DressSP value) {
                          setState(() => _dress = value);
                          _entry.setSP = value;
                        },
                      ),
                      Text(
                        "SP",
                      ),
                    ],
                  ),
                  // vspcheck
                  Row(
                    children: <Widget>[
                      Radio(
                        value: DressSP.vsp,
                        groupValue: _dress,
                        onChanged: (DressSP value) {
                          setState(() => _dress = value);
                          _entry.setSP = value;
                        },
                      ),
                      Text(
                        "VSP",
                      ),
                    ],
                  ),
                  // vvspcheck
                  Row(
                    children: <Widget>[
                      Radio(
                        value: DressSP.vvsp,
                        groupValue: _dress,
                        onChanged: (DressSP value) {
                          setState(() => _dress = value);
                          _entry.setSP = value;
                        },
                      ),
                      Text(
                        "VVSP",
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
