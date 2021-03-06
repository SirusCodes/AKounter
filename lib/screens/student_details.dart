import '../locator.dart';
import '../models/entry_model.dart';
import '../provider/add_entry_provider.dart';
import '../provider/entry_provider.dart';
import 'add_data/add_entry.dart';
import 'requirements/student_requirements_list.dart';
import '../widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data.dart';

class StudentDetails extends StatelessWidget {
  final _belts = [
    "White",
    "Orange",
    "Yellow",
    "Green",
    "Blue",
    "Purple",
    "Brown 3",
    "Brown 2",
    "Brown 1",
    "Black"
  ];

  final _student = locator<Data>().getStudent;
  @override
  Widget build(BuildContext context) {
    List<EntryModel> _entryLists = [];
    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            fit: FlexFit.loose,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    elevation: 0.0,
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.book),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => StudentRequirementsList())),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddEntry()));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.call),
                        onPressed: () => launch("tel:${_student.number}"),
                      ),
                    ],
                    pinned: true,
                    expandedHeight: 150.0,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(_student.name),
                      background: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Number : ${_student.number}",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                "Member : ${_student.gender}",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Belt : ${_belts[_student.belt]}",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                // This might look weird but it is because of linting
                                "Fees Till : ${formatDate(_student.fees, [
                                  mm,
                                  "/",
                                  yyyy
                                ])}",
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: Consumer<EntryProvider>(
                builder: (_, _entries, __) {
                  return StreamBuilder(
                    stream: _entries.fetchEntriesAsStream(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        _entryLists = snapshot.data.docs
                            .map((f) => EntryModel.fromJson(f.data(), f.id))
                            .toList();
                        return ListView.builder(
                          itemCount: _entryLists.length,
                          itemBuilder: (context, int i) {
                            return Card(
                              elevation: 3.0,
                              child: ListTile(
                                title: Text(_entryLists[i].reason),
                                subtitle: Text(
                                  _entryLists[i].detailedReason +
                                      "  " +
                                      formatDate(
                                        _entryLists[i].date,
                                        ["dd", "/", "mm", "/", "yyyy"],
                                      ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete,
                                      color: Theme.of(context).accentColor),
                                  onPressed: () {
                                    cSnackBar(
                                      context,
                                      message: "Entry is deleted",
                                    );
                                    locator<AddEntryProvider>()
                                        .delete(_entryLists[i]);
                                  },
                                ),
                                onTap: () {},
                              ),
                            );
                          },
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RichText(
                text: TextSpan(
                  text: "Made with ❤ by ",
                  style: TextStyle(color: Theme.of(context).accentColor),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Darshan",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launch(
                            "https://www.linkedin.com/in/darshan-rander-b28a3b193/"),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
