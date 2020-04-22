import 'package:cloud_firestore/cloud_firestore.dart';
import '../data.dart';
import '../locator.dart';

class RequirementServices {
  Firestore _db = Firestore.instance;
  CollectionReference ref;

  var _id = locator<Data>();

  RequirementServices() {
    _db.settings(persistenceEnabled: true);
    _updateDB();
  }

  Future<QuerySnapshot> getDataCollection() {
    _updateDB();
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection(String equip) {
    _updateDB();
    return ref.where("requirement_type", isEqualTo: equip).snapshots();
  }

  Future<DocumentSnapshot> getRequirementById(String id) {
    _updateDB();
    return ref.document(id).get();
  }

  Future<void> removeRequirement(String id) {
    _updateDB();
    return ref.document(id).delete();
  }

  Future<DocumentReference> addRequirement(Map data, String id) {
    _updateDB();
    return ref.document(id).setData(data);
  }

  Future<void> updateRequirement(Map data, String id) {
    _updateDB();
    return ref.document(id).updateData(data);
  }

  void _updateDB() {
    ref = _db
        .collection("branches")
        .document(_id.getBranch.id)
        .collection("requirements");
  }
}
