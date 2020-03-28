import 'package:akounter/screens/add_data/add_entry.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentDetails extends StatefulWidget {
  @override
  _StudentDetailsState createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
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
                  onPressed: () => launch("tel:1234567890"),
                ),
              ],
              pinned: true,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Dummy name"),
                background: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Roll No. : Dummy no.",
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          "Branch : Test Branch",
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          "Number : 1234567890",
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
                          "Belt : white",
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          "Fee Paid Till : Jan",
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          "Member : No",
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
