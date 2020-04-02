import 'package:akounter/locator.dart';
import 'package:akounter/models/entry_model.dart';
import 'package:akounter/provider/entry_provider.dart';
import 'package:akounter/screens/add_data/add_entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  final _student = locator<Data>().getStudent;
  @override
  Widget build(BuildContext context) {
    List<EntryModel> _entryLists = List<EntryModel>();
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              elevation: 0.0,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddEntry()));
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
                          "Fees Till : ${_months[_student.fees]}",
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
        body: Container(
          color: Theme.of(context).primaryColor,
          child: Consumer<EntryProvider>(
            builder: (_, _entries, __) {
              return StreamBuilder(
                stream: _entries.fetchEntriesAsStream(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    _entryLists = snapshot.data.documents
                        .map((f) => EntryModel.fromJson(f.data, f.documentID))
                        .toList();
                    return ListView.builder(
                      itemCount: _entryLists.length,
                      itemBuilder: (context, int i) {
                        return Card(
                          elevation: 3.0,
                          child: ListTile(
                            title: Text(_entryLists[i].reason),
                            subtitle: Text(_entryLists[i].detailedReason +
                                "  " +
                                _entryLists[i].date),
                            // trailing: IconButton(
                            //   icon: Icon(Icons.delete,
                            //       color: Theme.of(context).accentColor),
                            //   onPressed: () {},
                            // ),
                            onTap: () {},
                          ),
                        );
                      },
                    );
                  } else {
                    return Container(
                      child: Text(
                        "NO Entries",
                        style: Theme.of(context).textTheme.display1,
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
