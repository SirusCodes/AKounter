import 'package:cloud_firestore/cloud_firestore.dart';

class BranchServices {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  BranchServices(this.path) {
    ref = _db.collection(path);
    _db.settings(persistenceEnabled: true);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getBranchById(String id) {
    return ref.document(id).get();
  }

  Future<void> removeBranch(String id) {
    return ref.document(id).delete();
  }

  Future<DocumentReference> addBranch(Map data) {
    return ref.add(data);
  }

  Future<void> updateBranch(Map data, String id) {
    return ref.document(id).updateData(data);
  }
}