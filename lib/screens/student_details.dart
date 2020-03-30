import 'package:akounter/models/student_model.dart';
import 'package:akounter/screens/add_data/add_entry.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({this.student});
  final StudentModel student;
  @override
  _StudentDetailsState createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  var _belts = [
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
  var _months = [
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
                  onPressed: () => launch("tel:${widget.student.number}"),
                ),
              ],
              pinned: true,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(widget.student.name),
                background: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Number : ${widget.student.number}",
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          "Member : ${widget.student.gender}",
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
                          "Belt : ${_belts[widget.student.belt]}",
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          "Fees Till : ${_months[widget.student.fees]}",
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
