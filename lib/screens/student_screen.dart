import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../locator.dart';
import '../models/student_model.dart';
import '../provider/student_provider.dart';
import '../widgets/snackbar.dart';
import 'add_data/add_entry.dart';
import 'add_data/add_students.dart';
import 'student_details.dart';

List<Color> beltColors = [
  Colors.grey[200],
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.purple,
  Colors.brown,
  Colors.grey[700],
  Colors.yellowAccent,
  Colors.black,
];

class StudentScreen extends StatelessWidget {
  const StudentScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _students = Provider.of<StudentProvider>(context);
    List<StudentModel> _studentList = [];
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Students"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: StudentSearch(studentList: _studentList));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: _students.fetchStudentesAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              _studentList = snapshot.data.docs
                  .map((f) => StudentModel.fromJson(f.data(), f.id))
                  .toList();
            }
            return Column(
              children: <Widget>[
                Center(child: Text("Tap and hold for student details")),
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView.builder(
                    itemCount: _studentList.length,
                    itemBuilder: (context, int i) {
                      return Card(
                        elevation: 5.0,
                        child: ListTile(
                          leading: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddStudent(student: _studentList[i]),
                                ),
                              );
                            },
                          ),
                          title: Text(_studentList[i].name),
                          onTap: () {
                            locator<Data>().setStudent = _studentList[i];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddEntry(),
                              ),
                            );
                          },
                          onLongPress: () {
                            locator<Data>().setStudent = _studentList[i];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StudentDetails(),
                              ),
                            );
                          },
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: beltColors[_studentList[i].belt],
                            ),
                            onPressed: () {
                              cSnackBar(
                                context,
                                message:
                                    "Do you really want to delete ${_studentList[i].name}?",
                                button: FlatButton(
                                  onPressed: () {
                                    _students.removeStudent(_studentList[i].id);
                                  },
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Add Student"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddStudent(
                student: StudentModel(id: null),
              ),
            ),
          );
        },
      ),
    );
  }
}

//
// search
//
class StudentSearch extends SearchDelegate {
  StudentSearch({this.studentList});
  List<StudentModel> studentList;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<StudentModel> _studentList = studentList
        .where((t) => t.name.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: _studentList.length,
      itemBuilder: (context, int i) {
        return Card(
          elevation: 3.0,
          child: ListTile(
            leading: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddStudent(student: _studentList[i]),
                  ),
                );
              },
            ),
            title: Text(_studentList[i].name),
            onTap: () {
              locator<Data>().setStudent = _studentList[i];
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEntry(),
                ),
              );
            },
            onLongPress: () {
              locator<Data>().setStudent = _studentList[i];
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentDetails(),
                ),
              );
            },
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                StudentProvider().removeStudent(_studentList[i].id);
              },
            ),
          ),
        );
      },
    );
  }
}
