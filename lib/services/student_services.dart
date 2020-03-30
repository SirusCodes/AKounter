import 'package:cloud_firestore/cloud_firestore.dart';

class StudentServices {
  final Firestore _db = Firestore.instance;
  String id;
  CollectionReference ref;

  StudentServices(this.id) {
    ref = _db.collection("branches").document(id).collection("students");
    _db.settings(persistenceEnabled: true);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getStudentById(String id) {
    return ref.document(id).get();
  }

  Future<void> removeStudent(String id) {
    return ref.document(id).delete();
  }

  Future<DocumentReference> addStudent(Map data) {
    return ref.add(data);
  }

  Future<void> updateStudent(Map data, String id) {
    return ref.document(id).updateData(data);
  }
}
