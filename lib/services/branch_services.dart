import 'package:cloud_firestore/cloud_firestore.dart';

import '../data.dart';
import '../locator.dart';

class BranchServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  CollectionReference ref;

  BranchServices(this.path) {
    FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.get();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    print(locator<Data>().getUser.mailID);
    return ref
        .where("instructors", arrayContains: locator<Data>().getUser.mailID)
        .snapshots();
  }

  Future<DocumentSnapshot> getBranchById(String id) {
    return ref.doc(id).get();
  }

  Future<void> removeBranch(String id) {
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addBranch(Map data) {
    return ref.add(data);
  }

  Future<void> updateBranch(Map data, String id) {
    return ref.doc(id).update(data);
  }
}
