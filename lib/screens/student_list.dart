import 'package:akounter/screens/add_data/add_students.dart';
import 'package:akounter/screens/in_dev.dart';
import 'package:flutter/material.dart';

class StudentList extends StatelessWidget {
  const StudentList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Students"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddStudent()),
              );
            },
          )
        ],
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Card(
                elevation: 3.0,
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text(
                    "Test student",
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InDevelopment(
                              text: "This will divert to show add fees n all")),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
