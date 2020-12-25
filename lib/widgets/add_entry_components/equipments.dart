import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/add_entry_provider.dart';

class Equipments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddEntryProvider>(
      builder: (_, _entry, __) {
        return GridView.count(
          childAspectRatio: 3.2,
          shrinkWrap: true,
          crossAxisCount: 2,
          children: <Widget>[
            _checkBoxWithText(
              Checkbox(
                value: _entry.getGloves,
                onChanged: (value) => _entry.setGloves = value,
              ),
              "Gloves",
            ),
            _checkBoxWithText(
              Checkbox(
                value: _entry.getKickpad,
                onChanged: (value) => _entry.setKickpad = value,
              ),
              "Kickpad",
            ),
            _checkBoxWithText(
                Checkbox(
                  value: _entry.getChestguard,
                  onChanged: (value) => _entry.setChestguard = value,
                ),
                "ChestGuard"),
            _checkBoxWithText(
              Checkbox(
                value: _entry.getFootguard,
                onChanged: (value) => _entry.setFootguard = value,
              ),
              "FootGuard",
            ),
          ],
        );
      },
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
