import 'package:akounter/locator.dart';
import 'package:akounter/models/student_model.dart';
import 'package:akounter/provider/student_provider.dart';
import 'package:akounter/screens/add_data/add_entry.dart';
import 'package:akounter/screens/add_data/add_students.dart';
import 'package:akounter/screens/student_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _students = Provider.of<StudentProvider>(context);
    List<StudentModel> _studentList = List<StudentModel>();
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
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: _students.fetchStudentesAsStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                _studentList = snapshot.data.documents
                    .map((f) => StudentModel.fromJson(f.data, f.documentID))
                    .toList();
              }
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
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _students.removeStudent(_studentList[i].id);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
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
