import 'package:akounter/models/requirements_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data.dart';
import '../locator.dart';

class RequirementServices {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference ref;

  var _id = locator<Data>();

  RequirementServices() {
    FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
    _updateDB();
  }

  Future<QuerySnapshot> getDataCollection() {
    _updateDB();
    return ref.get();
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
    return ref.doc(id).get();
  }

  Future<void> removeRequirement(String id) {
    _updateDB();
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addRequirement(Map data, String id) {
    _updateDB();
    return ref.doc(id).set(data);
  }

  Future<void> updateRequirement(Map data, String id) {
    _updateDB();
    return ref.doc(id).update(data);
  }

  batchedUpdateRequirements(List<RequirementModel> list) {
    _updateDB();
    var _batch = _db.batch();
    int writes = 0;
    for (var item in list) {
      if (writes <= 500) {
        writes++;
        _batch.update(ref.doc(item.id), item.toJson());
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
        .doc(_id.getBranch.id)
        .collection("requirements");
  }
}
