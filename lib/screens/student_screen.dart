import 'package:akounter/models/student_model.dart';
import 'package:akounter/provider/student_provider.dart';
import 'package:akounter/screens/add_data/add_students.dart';
import 'package:akounter/screens/student_details.dart';
import 'package:akounter/services/student_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({Key key, this.branchID}) : super(key: key);
  final String branchID;
  @override
  Widget build(BuildContext context) {
    StudentServices(branchID);
    print(branchID);
    final _students = Provider.of<StudentProvider>(context);
    List<StudentModel> _studentList = List<StudentModel>();
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
                MaterialPageRoute(
                  builder: (context) => AddStudent(
                    student: StudentModel(id: null),
                  ),
                ),
              );
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentDetails(
                              student: _studentList[i],
                            ),
                          ),
                        );
                      },
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          print(_studentList[i].name);
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
    );
  }
}
