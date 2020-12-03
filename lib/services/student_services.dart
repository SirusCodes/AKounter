import 'package:akounter/models/student_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../data.dart';
import '../locator.dart';

class StudentServices {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference ref;

  var _id = locator<Data>();

  StudentServices() {
    FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
    _updateDB();
  }

  Future<QuerySnapshot> getDataCollection() {
    _updateDB();
    return ref.get();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    _updateDB();
    return ref.orderBy("belt").snapshots();
  }

  Future<DocumentSnapshot> getStudentById(String id) {
    _updateDB();
    return ref.doc(id).get();
  }

  Future<void> removeStudent(String id) {
    _updateDB();
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addStudent(Map data) {
    _updateDB();
    return ref.add(data);
  }

  Future<void> updateStudent(Map data, String id) {
    _updateDB();
    return ref.doc(id).update(data);
  }

  Future<void> transactionStudent(List<StudentModel> list) {
    Uuid _uuid = Uuid();
    WriteBatch batch = FirebaseFirestore.instance.batch();
    for (final model in list) {
      print(ref.doc(_uuid.v1()));
      batch.set(ref.doc(_uuid.v1()), model.toJson());
    }
    return batch.commit();
  }

  void _updateDB() {
    ref =
        _db.collection("branches").doc(_id.getBranch.id).collection("students");
  }
}
