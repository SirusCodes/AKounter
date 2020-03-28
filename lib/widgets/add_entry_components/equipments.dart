import 'package:flutter/material.dart';

class Equipments extends StatefulWidget {
  const Equipments({Key key}) : super(key: key);

  @override
  _EquipmentsState createState() => _EquipmentsState();
}

class _EquipmentsState extends State<Equipments> {
  bool _gloves = false,
      _kickpad = false,
      _chestguard = false,
      _footguard = false;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 3.2,
      shrinkWrap: true,
      crossAxisCount: 2,
      children: <Widget>[
        _checkBoxWithText(
          Checkbox(
            value: _gloves,
            onChanged: (value) => setState(() => _gloves = value),
          ),
          "Gloves",
        ),
        _checkBoxWithText(
          Checkbox(
            value: _kickpad,
            onChanged: (value) => setState(() => _kickpad = value),
          ),
          "Kickpad",
        ),
        _checkBoxWithText(
            Checkbox(
              value: _chestguard,
              onChanged: (value) => setState(() => _chestguard = value),
            ),
            "ChestGuard"),
        _checkBoxWithText(
          Checkbox(
            value: _footguard,
            onChanged: (value) => setState(() => _footguard = value),
          ),
          "FootGuard",
        ),
      ],
    );
  }

  Widget _checkBoxWithText(Checkbox checkbox, String text) {
    return Row(
      children: <Widget>[
        checkbox,
        Text(text),
      ],
    );
  }
}
