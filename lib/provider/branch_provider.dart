import '../models/branch_model.dart';
import '../services/branch_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BranchProvider {
  BranchServices _branches = BranchServices("branches");

  List<BranchModel> products;

  Future<List<BranchModel>> fetchBranches() async {
    var result = await _branches.getDataCollection();
    products = result.docs
        .map((doc) => BranchModel.fromJson(doc.data(), doc.id))
        .toList();
    return products;
  }

  Stream<QuerySnapshot> fetchBranchesAsStream() {
    return _branches.streamDataCollection();
  }

  Future<BranchModel> getBranchById(String id) async {
    var doc = await _branches.getBranchById(id);
    return BranchModel.fromJson(doc.data(), doc.id);
  }

  Future removeBranch(String id) async {
    await _branches.removeBranch(id);
    return;
  }

  Future updateBranch(BranchModel data, String id) async {
    await _branches.updateBranch(data.toJson(), id);
    return;
  }

  Future addBranch(BranchModel _branch) async {
    await _branches.addBranch(_branch.toJson());
    return;
  }
}
