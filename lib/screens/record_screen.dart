import 'package:flutter/material.dart';

import '../extensions/date_extention.dart';
import '../provider/database_manager.dart';
import '../widgets/snackbar.dart';

class RecordsScreen extends StatelessWidget {
  const RecordsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Records"),
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Upload"),
            trailing: Icon(Icons.file_upload),
            enabled: false,
          ),
          ListTile(
            title: Text("Get balance record"),
            trailing: Icon(Icons.file_download),
            onTap: () async {
              final selectedDateRange = await _showDatePicker(context);
              if (selectedDateRange != null) {
                final path = await DatabaseManager()
                    .monthlyBalanceSheet(selectedDateRange);

                _showResult(path, context);
              }
            },
          ),
          ListTile(
            title: Text("Get monthly sheet"),
            trailing: Icon(Icons.file_download),
            onTap: () async {
              final selectedDateRange = await _showDatePicker(context);
              if (selectedDateRange != null) {
                final path =
                    await DatabaseManager().monthlyRecord(selectedDateRange);

                _showResult(path, context);
              }
            },
          ),
        ],
      ),
    );
  }

  void _showResult(String path, BuildContext context) {
    if (path != null) {
      cSnackBar(context, message: "File saved at $path");
    } else {
      cSnackBar(context, message: "Error saving file");
    }
  }

  _showDatePicker(BuildContext context) {
    return showDateRangePicker(
      context: context,
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime.now().copyWith(
        year: DateTime.now().year + 1,
      ),
      initialDateRange: DateTimeRange(
        start: DateTime.now().copyWith(
          month: DateTime.now().month - 1,
        ),
        end: DateTime.now(),
      ),
    );
  }
}
