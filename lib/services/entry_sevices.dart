import 'package:cloud_firestore/cloud_firestore.dart';
import '../data.dart';
import '../locator.dart';

class EntryServices {
  Firestore _db = Firestore.instance;
  CollectionReference ref;

  var _id = locator<Data>();

  EntryServices() {
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

  Stream<QuerySnapshot> streamAllEntriesCollection(String date) {
    return _db
        .collectionGroup("entry")
        .where("instructors", arrayContains: _id.getUser.mailID)
        .where("branch", isEqualTo: _id.getBranch.name)
        .where("date", isEqualTo: date)
        .snapshots();
  }

  Future<DocumentSnapshot> getEntryById(String id) {
    _updateDB();
    return ref.document(id).get();
  }

  Future<void> removeEntry(String id) {
    _updateDB();
    return ref.document(id).delete();
  }

  Future<DocumentReference> addEntry(Map data) {
    _updateDB();
    return ref.add(data);
  }

  Future<void> updateEntry(Map data, String id) {
    _updateDB();
    return ref.document(id).updateData(data);
  }

  void _updateDB() {
    print(_id.getBranch.id);
    ref = _db
        .collection("branches")
        .document(_id.getBranch.id)
        .collection("students")
        .document(_id.getStudent.id)
        .collection("entry");
  }
}
