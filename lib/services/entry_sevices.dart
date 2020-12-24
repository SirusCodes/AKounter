import 'package:akounter/models/entry_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data.dart';
import '../locator.dart';

class EntryServices {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference ref;

  var _id = locator<Data>();

  EntryServices() {
    FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
    _updateDB();
  }

  Future<QuerySnapshot> getDataCollection() {
    _updateDB();
    return ref.get();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    _updateDB();
    return ref.snapshots();
  }

  Stream<QuerySnapshot> streamAllEntriesCollection(Timestamp date) {
    return _db
        .collectionGroup("entries")
        .where("branch", isEqualTo: _id.getBranch.id)
        .where("date", isEqualTo: date)
        .snapshots();
  }

  Future<QuerySnapshot> entriesForMonths(List<Timestamp> dateRange) {
    return _db
        .collectionGroup("entries")
        .where("branch", isEqualTo: _id.getBranch.id)
        .where("reason", isEqualTo: "Monthly")
        .where("months_paid", arrayContainsAny: dateRange)
        .get();
  }

  Future<QuerySnapshot> entriesBetween(Timestamp start, Timestamp end) {
    return _db
        .collectionGroup("entries")
        .where("branch", isEqualTo: _id.getBranch.id)
        .where("reason", isEqualTo: "Monthly")
        .where(
          "date",
          isGreaterThanOrEqualTo: start,
          isLessThanOrEqualTo: end,
        )
        .get();
  }

  Future<DocumentSnapshot> getEntryById(String id) {
    _updateDB();
    return ref.doc(id).get();
  }

  Future<void> removeEntry(String id) {
    _updateDB();
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addEntry(Map data) {
    _updateDB();
    return ref.add(data);
  }

  Future<void> updateEntry(Map data, String id) {
    _updateDB();
    return ref.doc(id).update(data);
  }

  void _updateDB() {
    print(_id.getBranch.id);
    ref = _db
        .collection("branches")
        .doc(_id.getBranch.id)
        .collection("students")
        .doc(_id.getStudent.id)
        .collection("entries");
  }
}
