import 'package:akounter/models/requirements_model.dart';
import 'package:akounter/services/requirement_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequirementProvider {
  RequirementServices _requirements = RequirementServices();

  List<RequirementModel> requirements;

  Future<List<RequirementModel>> fetchRequirements() async {
    var result = await _requirements.getDataCollection();
    requirements = result.documents
        .map((doc) => RequirementModel.fromJson(doc.data, doc.documentID))
        .toList();
    return requirements;
  }

  Stream<QuerySnapshot> fetchRequirementsAsStream(String equip) {
    return _requirements.streamDataCollection(equip);
  }

  Stream<QuerySnapshot> fetchRequirementsAsStreamIssued() {
    return _requirements.streamDataCollectionIssued();
  }

  Future<RequirementModel> getRequirementById(String id) async {
    var doc = await _requirements.getRequirementById(id);
    return RequirementModel.fromJson(doc.data, doc.documentID);
  }

  Future removeRequirement(String id) async {
    await _requirements.removeRequirement(id);
    return;
  }

  Future updateRequirement(RequirementModel data, String id) async {
    await _requirements.updateRequirement(data.toJson(), id);
    return;
  }

  Future addRequirement(RequirementModel _requirement, String id) async {
    await _requirements.addRequirement(_requirement.toJson(), id);
    return;
  }
}
