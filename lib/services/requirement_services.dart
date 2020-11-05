import 'package:akounter/models/requirements_model.dart';
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
    return ref
        .where("requirement_type", isEqualTo: equip)
        .where("issued", isEqualTo: false)
        .snapshots();
  }

  Stream<QuerySnapshot> streamDataCollectionIssued() {
    _updateDB();
    return ref
        .where("issued", isEqualTo: true)
        .where("student_id", isEqualTo: _id.getStudent.id)
        .snapshots();
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

  batchedUpdateRequirements(List<RequirementModel> list) {
    _updateDB();
    var _batch = _db.batch();
    int writes = 0;
    for (var item in list) {
      if (writes <= 500) {
        writes++;
        _batch.updateData(ref.document(item.id), item.toJson());
      } else {
        writes = 0;
        _batch.commit();
      }
    }
    if (writes <= 500) _batch.commit();
  }

  void _updateDB() {
    ref = _db
        .collection("branches")
        .document(_id.getBranch.id)
        .collection("requirements");
  }
}
