import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/add_entry_provider.dart';

class Examination extends StatelessWidget {
  const Examination({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddEntryProvider>(
      builder: (_, _entry, __) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              _entry.getDetailedReason,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Colors.black),
            ),
          ),
        );
      },
    );
  }
}
