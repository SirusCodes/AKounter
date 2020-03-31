import 'package:cloud_firestore/cloud_firestore.dart';
import '../doc_id.dart';

class StudentServices {
  Firestore _db = Firestore.instance;
  CollectionReference ref;

  StudentServices() {
    _db.settings(persistenceEnabled: true);
    _updateDB();
  }

  Future<QuerySnapshot> getDataCollection() {
    _updateDB();
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    _updateDB();
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getStudentById(String id) {
    _updateDB();
    return ref.document(id).get();
  }

  Future<void> removeStudent(String id) {
    _updateDB();
    return ref.document(id).delete();
  }

  Future<DocumentReference> addStudent(Map data) {
    _updateDB();
    return ref.add(data);
  }

  Future<void> updateStudent(Map data, String id) {
    _updateDB();
    return ref.document(id).updateData(data);
  }

  void _updateDB() {
    ref = _db
        .collection("branches")
        .document(DocID().getBranchID)
        .collection("students");
  }
}
