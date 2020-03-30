import 'package:akounter/models/student_model.dart';
import 'package:akounter/services/student_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class StudentProvider with ChangeNotifier {
  static String _id = "";

  set id(String docID) {
    _id = docID;
  }

  StudentServices _students = StudentServices(_id);

  List<StudentModel> products;

  Future<List<StudentModel>> fetchStudentes() async {
    var result = await _students.getDataCollection();
    products = result.documents
        .map((doc) => StudentModel.fromJson(doc.data, doc.documentID))
        .toList();
    return products;
  }

  Stream<QuerySnapshot> fetchStudentesAsStream() {
    print(_id + " from provider");

    return _students.streamDataCollection();
  }

  Future<StudentModel> getStudentById(String id) async {
    var doc = await _students.getStudentById(id);
    return StudentModel.fromJson(doc.data, doc.documentID);
  }

  Future removeStudent(String id) async {
    await _students.removeStudent(id);
    return;
  }

  Future updateStudent(StudentModel data, String id) async {
    await _students.updateStudent(data.toJson(), id);
    return;
  }

  Future addStudent(StudentModel _student) async {
    await _students.addStudent(_student.toJson());
    return;
  }
}
