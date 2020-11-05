import 'package:akounter/models/entry_model.dart';
import 'package:akounter/provider/add_entry_provider.dart';
import 'package:akounter/provider/entry_provider.dart';
import 'package:akounter/provider/student_provider.dart';
import 'package:akounter/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../locator.dart';

class BranchEntryList extends StatefulWidget {
  const BranchEntryList({Key key}) : super(key: key);

  @override
  _BranchEntryListState createState() => _BranchEntryListState();
}

class _BranchEntryListState extends State<BranchEntryList> {
  List<EntryModel> _entryList = [];
  String _date;
  int _total = 0;

  bool _showList = false, _isAllDeleted = false;

  var _student = locator<Data>();

  @override
  void initState() {
    _date = formatDate(DateTime.now(), ["dd", "/", "mm", "/", "yyyy"]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entries"),
        elevation: 0.0,
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 15.0).copyWith(top: 15.0),
        child: Column(
          children: <Widget>[
            Card(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      OutlineButton(
                        child: Text(_date),
                        onPressed: () => DatePicker.showDatePicker(
                          context,
                          maxTime: DateTime.now(),
                          showTitleActions: true,
                          onConfirm: (DateTime date) {
                            setState(() {
                              _date = formatDate(
                                  date, ["dd", "/", "mm", "/", "yyyy"]);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              elevation: 3.0,
            ),
            Consumer<EntryProvider>(
              builder: (_, _entries, __) {
                final _studentProvider = Provider.of<StudentProvider>(context);
                return StreamBuilder(
                  stream: _entries.fetchAllEntriesAsStream(_date),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData && !_isAllDeleted) {
                      _entryList = snapshot.data.docs
                          .map((f) => EntryModel.fromJson(f.data(), f.id))
                          .toList();

                      _total = _entryList.fold(0, (t, e) => t + e.total);
                      _showList = true;
                    }
                    if (_showList) {
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Total: $_total",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: _entryList.length,
                            itemBuilder: (context, int i) {
                              return Card(
                                elevation: 3.0,
                                child: ListTile(
                                  title: Text(_entryList[i].name),
                                  subtitle: Text(_entryList[i].reason +
                                      "  " +
                                      _entryList[i].detailedReason),
                                  trailing: IconButton(
                                    icon: _entryList[i].reason != "Equipments"
                                        ? Icon(
                                            Icons.delete,
                                            color:
                                                Theme.of(context).accentColor,
                                          )
                                        : Container(),
                                    onPressed: () async {
                                      if (_student.getStudent.id !=
                                          _entryList[i].studentID)
                                        _student.setStudent =
                                            await _studentProvider
                                                .getStudentById(
                                          _entryList[i].studentID,
                                        );

                                      locator<AddEntryProvider>()
                                          .delete(_entryList[i]);

                                      setState(() {
                                        if (_entryList.length == 1) {
                                          _isAllDeleted = true;
                                          _showList = false;
                                        }
                                      });

                                      cSnackBar(
                                        context,
                                        message: "Entry is deleted",
                                      );
                                    },
                                  ),
                                  onTap: () {},
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    } else {
                      return Container(
                        child: Text(
                          "NO Entries",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
