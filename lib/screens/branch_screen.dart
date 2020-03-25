import './add_data/add_branches.dart';
import './student_list.dart';
import 'package:flutter/material.dart';

class BranchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Branches"),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddBranch()),
              );
            },
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 3.0,
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text("Test Branch"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentList(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
