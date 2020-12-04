import '../data.dart';
import '../enums/dress_size_enum.dart';
import '../locator.dart';
import '../models/entry_model.dart';
import '../models/requirements_model.dart';
import '../models/student_model.dart';
import 'branch_provider.dart';
import 'entry_provider.dart';
import 'requirement_provider.dart';
import 'student_provider.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/foundation.dart';
import '../extensions/date_extention.dart';

//! may refactor it later

class AddEntryProvider extends ChangeNotifier {
  static int _total = 0, _subtotal = 0, _pending = 0, _amountGiven;
  static String _reason = "Monthly", _detailedReason, _invoiceNo, _reqID;
  static List<DateTime> monthRange = [];

  String get getReqID => _reqID;

  List<DateTime> getMonthRange = monthRange;

  var _data = locator<Data>();

  var _belts = [
    "White",
    "Orange",
    "Yellow",
    "Green",
    "Blue",
    "Purple",
    "Brown 3",
    "Brown 2",
    "Brown 1",
    "Black"
  ];
  var _months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  bool _gloves = false,
      _kickpad = false,
      _chestguard = false,
      _footguard = false;

  // total subtotal and pending
  set setTotal(int total) {
    _total = total;
  }

  set setSubtotal(int subtotal) {
    _subtotal = subtotal;
    updateTotal();
  }

  set setPending(int pending) {
    _pending = pending;
  }

  int get getTotal => _total;
  int get getSubtotal => _subtotal;
  int get getPending => _pending;

  // amount given
  set setAmountGiven(int amountGiven) {
    _amountGiven = amountGiven;
  }

  // reason and detailed reason
  set setReason(String reason) {
    _reason = reason;
    if (reason == "Examination") examination();
  }

  set setDetailedReason(String detailReason) {
    _detailedReason = detailReason;
    print(detailReason);
  }

  String get getDetailedReason => _detailedReason;
  String get getReason => _reason;

  //
  // monthy
  //
  static int _totalMonth = 1;
  void monthly(int perMonth, int totalMonth) {
    _subtotal = perMonth * _totalMonth;
    updateTotal();
    print(_subtotal);
  }

  // getter and setter for total months
  int get getTotalMonth => _totalMonth;
  set setTotalMonth(int value) {
    _totalMonth = value;
  }

  String updateAsMonthly() {
    List<String> detailedReason = [];
    int current = _data.getStudent.fees.month - 1;

    for (int i = 0; i < _totalMonth; i++) {
      // -1 so in next iteration it will be 0
      if (current == 11) current = -1;
      detailedReason.add(_months[++current]);
    }
    String str = detailedReason.toString();
    return str.substring(1, str.length - 1);
  }

  // invoice
  set invoice(String invoice) {
    _invoiceNo = invoice;
  }

  //
  // examination
  //
  void examination() {
    if (_data.getStudent.belt < 8) {
      _detailedReason =
          "${_belts[_data.getStudent.belt]} to ${_belts[_data.getStudent.belt + 1]}";
      updateAsExam(_data.getStudent.belt);
    } else
      _detailedReason = "Can't handle dan belts yet";
    notifyListeners();
  }

  void updateAsExam(int belt) {
    _subtotal = 600;
    for (int i = 1; i <= belt; i++) {
      if (i < 5)
        _subtotal += 50;
      else if (i == 5)
        _subtotal += 100;
      else
        _subtotal += 200;
    }
    updateTotal();
  }

  //
  // equipment
  //
  set setGloves(bool gloves) {
    _gloves = gloves;
    equipment();
  }

  set setKickpad(bool newkickpad) {
    _kickpad = newkickpad;
    equipment();
  }

  set setChestguard(bool newchestguard) {
    _chestguard = newchestguard;
    equipment();
  }

  set setFootguard(bool newfootguard) {
    _footguard = newfootguard;
    equipment();
  }

  bool get getGloves => _gloves;
  bool get getKickpad => _kickpad;
  bool get getChestguard => _chestguard;
  bool get getFootguard => _footguard;

  void equipment() {
    _subtotal = 0;

    if (_gloves) _subtotal += 450;

    if (_kickpad) _subtotal += 550;

    if (_chestguard) _subtotal += 750;

    if (_footguard) _subtotal += 850;

    updateTotal();
  }

  String detailEquipment() {
    List<String> equip = [];
    String detailedReason = "";

    if (_gloves) equip.add("Gloves");
    if (_kickpad) equip.add("Kickpad");
    if (_chestguard) equip.add("Chestguard");
    if (_footguard) equip.add("Footguard");

    detailedReason = equip.toString();
    detailedReason = detailedReason.substring(1, detailedReason.length - 1);

    return detailedReason;
  }

  //
  // dress
  //
  DressSP _dressSP = DressSP.none;
  int _size;
  setSP(DressSP sp) {
    _dressSP = sp;
    dress(_size);
  }

  set setSize(int size) {
    _size = size;
    dress(size);
  }

  void dress(int size) {
    if (size > 11 && size < 25) _subtotal = updateAsDress(size);

    if (_dressSP == DressSP.sp) _subtotal += 30;
    if (_dressSP == DressSP.vsp) _subtotal += 60;
    if (_dressSP == DressSP.vvsp) _subtotal += 120;

    updateTotal();
  }

  int updateAsDress(int size) {
    int subtotal = 660;
    if (size == 12 || size == 13) return subtotal;
    if (size == 24) return 1000;
    for (int i = 14; i <= size; i++) {
      subtotal += 30;
    }
    return subtotal;
  }

  String detailDress() {
    String detailedReason = _size.toString() + " ";

    if (_dressSP == DressSP.sp) detailedReason += "SP";
    if (_dressSP == DressSP.vsp) detailedReason += "VSP";
    if (_dressSP == DressSP.vvsp) detailedReason += "VVSP";

    return detailedReason;
  }

  //
  // save
  //
  void save() {
    switch (_reason) {
      case "Monthly":
        _detailedReason = updateAsMonthly();
        if (_data.getBranch.indirectPayment) _reason += "($_invoiceNo)";
        _getMonthRange();
        break;
      case 'Equipments':
        _detailedReason = detailEquipment();
        _postSaveEquip();
        break;
      case 'Dress':
        _detailedReason = detailDress();
        _postSaveDress();
        break;
      case 'Card':
        _detailedReason = "Card";
        break;
    }

    _pending = _amountGiven - _total;
  }

  void _getMonthRange() {
    var _date = _data.getStudent.fees;
    monthRange.clear();
    for (var i = 0; i < _totalMonth; i++) {
      _date = _date.copyWith(month: _date.month + 1);
      monthRange.add(_date);
    }
    postSaveStudent(_date);
  }

  void postSaveStudent(DateTime date) {
    if (_pending != _data.getStudent.pending) {
      _data.getStudent.pending = _pending;
    }
    if (_reason.startsWith("Monthly")) {
      _data.getStudent.fees = monthRange.last;
      StudentProvider().updateStudent(_data.getStudent, _data.getStudent.id);
    } else if (_reason == "Examination") {
      _data.getStudent.belt++;
      StudentProvider().updateStudent(_data.getStudent, _data.getStudent.id);
    }
  }

  //! requirement update
  _postSaveEquip() {
    RequirementModel _model = RequirementModel();
    _reqID = formatDate(
      DateTime.now(),
      [dd, "-", mm, "-", yy, "_", hh, ":", nn, ":", ss, ":", SSS],
    );
    for (var requirement in _detailedReason.split(", ")) {
      _model.issued = false;
      _model.studentId = _data.getStudent.id;
      _model.studentName = _data.getStudent.name;
      _model.requirementType = requirement;
      _model.dressSize = "";
      RequirementProvider().addRequirement(_model, _reqID + "-" + requirement);
    }
    _updateBranchMap();
    _gloves = _kickpad = _chestguard = _footguard = false;
  }

  //! save for dress req
  _postSaveDress() {
    RequirementModel _model = RequirementModel();
    _reqID = formatDate(
      DateTime.now(),
      [dd, "-", mm, "-", yy, "_", hh, ":", nn, ":", ss, ":", SSS],
    );
    _model.issued = false;
    _model.studentId = _data.getStudent.id;
    _model.studentName = _data.getStudent.name;
    _model.requirementType = "Dress";
    _model.dressSize = _detailedReason;
    RequirementProvider().addRequirement(_model, _reqID + "-dress");
    _updateBranchMap();
  }

  // update branch
  _updateBranchMap() {
    var _branch = _data.getBranch;

    if (_gloves) _branch.requirements["Gloves"]++;
    if (_kickpad) _branch.requirements["Kickpad"]++;
    if (_chestguard) _branch.requirements["Chestguard"]++;
    if (_footguard) _branch.requirements["Footguard"]++;
    if (_reason == "Dress") _branch.requirements["Dress"]++;

    BranchProvider().updateBranch(_branch, _branch.id);
  }

  //
  // delete
  //
  void delete(EntryModel entry) {
    if (entry.detailedReason.startsWith("Monthly") ||
        entry.reason == "Examination") {
      _postDelete(entry);
    } else {
      switch (entry.reason) {
        case "Equipments":
          _postDeleteEquip(entry);
          break;
        case 'Dress':
          _postDeleteDress(entry);
          break;
      }
    }
    EntryProvider().removeEntry(entry.id);
  }

  //! delete for monthly and examination
  _postDelete(EntryModel entry) {
    StudentModel _studentmod = _data.getStudent;
    if (entry.reason.startsWith("Monthly")) {
      List list = entry.detailedReason.split(", ");
      _studentmod.fees = _studentmod.fees
          .copyWith(month: _studentmod.fees.month - list.length);
    } else if (entry.reason == "Examination") {
      _studentmod.belt--;
    }
    StudentProvider().updateStudent(_studentmod, _studentmod.id);
  }

  //! delete for equipment
  _postDeleteEquip(EntryModel entry) {
    //! TODO: check if any of the equipment is issued
    var _branch = _data.getBranch;
    for (var equip in entry.detailedReason.split(", ")) {
      RequirementProvider()
          .removeRequirement(entry.requirementID + "-" + equip);
      _branch.requirements[equip]--;
    }
    BranchProvider().updateBranch(_branch, _branch.id);
    EntryProvider().removeEntry(entry.id);
  }

  //! delete for dress req
  _postDeleteDress(EntryModel entry) {
    var _branch = _data.getBranch;
    RequirementProvider().removeRequirement(entry.requirementID + "-Dress");
    _branch.requirements["Dress"]--;
    BranchProvider().updateBranch(_branch, _branch.id);
    EntryProvider().removeEntry(entry.id);
  }

  // update
  void updateTotal() {
    _total = _subtotal - _pending;
    notifyListeners();
  }
}
