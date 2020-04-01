import 'package:akounter/locator.dart';
import 'package:akounter/screens/add_data/add_entry.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
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
              expandedHeight: 200.0,
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
        body: ListView(
          children: <Widget>[
            Card(
              elevation: 3.0,
              child: ListTile(
                title: Text("Dummy Entry"),
                trailing: IconButton(
                  icon:
                      Icon(Icons.delete, color: Theme.of(context).accentColor),
                  onPressed: () {},
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
