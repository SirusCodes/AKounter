import 'package:akounter/locator.dart';
import 'package:akounter/models/branch_model.dart';
import 'package:akounter/models/requirements_model.dart';
import 'package:akounter/provider/branch_provider.dart';
import 'package:akounter/services/requirement_services.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data.dart';

class RequirementsListProvider extends ChangeNotifier {
  static List<RequirementModel> _requirementsList,
      _changedList = List<RequirementModel>();

  static List<String> _changedListID = List<String>();

  static bool _showButton;

  init() {
    _showButton = false;
  }

  bool get getApply => _showButton;

  List<RequirementModel> get getList => _requirementsList;
  set setList(List<RequirementModel> list) {
    _requirementsList = list;
    _changedList.clear();
    _changedListID.clear();
  }

  changeIssued(int position) {
    _requirementsList[position].issued = !_requirementsList[position].issued;
    _requirementsList[position].issuedDate =
        formatDate(DateTime.now(), [dd, "/", mm, "/", yyyy]);
    _checkChange(_requirementsList[position]);
    notifyListeners();
  }

  Color getColor(int position, BuildContext context) {
    return _requirementsList[position].issued
        ? Colors.blueAccent
        : Colors.grey[400];
  }

  _checkChange(RequirementModel list) {
    if (_changedListID.contains(list.id)) {
      _changedList.remove(list);
      _changedListID.remove(list.id);
    } else {
      _changedListID.add(list.id);
      _changedList.add(list);
    }
    _showButton = _changedList.length > 0;
  }

  uploadChanges(String type) {
    RequirementServices services = RequirementServices();
    _updateBranch(type);
    services.batchedUpdateRequirements(_changedList);
    _showButton = false;
    notifyListeners();
  }

  _updateBranch(String type) {
    final _branch = locator<Data>().getBranch;
    BranchProvider _branchProvider = BranchProvider();
    BranchModel _branchModel = _branch;

    _branchModel.requirements[type] -= _changedList.length;

    _branchProvider.updateBranch(_branchModel, _branchModel.id);
  }
}
