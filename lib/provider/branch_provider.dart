import 'package:akounter/models/branch_model.dart';
import 'package:akounter/services/branch_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class BranchProvider with ChangeNotifier {
  BranchServices _branches = BranchServices("branches");
  BranchModel _branchModel = BranchModel();
  List<BranchModel> products;

  void setBranch(BranchModel branchModel) {
    _branchModel = branchModel;
  }

  BranchModel getBranch() => _branchModel;

  Future<List<BranchModel>> fetchBranches() async {
    var result = await _branches.getDataCollection();
    products = result.documents
        .map((doc) => BranchModel.fromMap(doc.data, doc.documentID))
        .toList();
    return products;
  }

  Stream<QuerySnapshot> fetchBranchesAsStream() {
    return _branches.streamDataCollection();
  }

  Future<BranchModel> getBranchById(String id) async {
    var doc = await _branches.getBranchById(id);
    return BranchModel.fromMap(doc.data, doc.documentID);
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
