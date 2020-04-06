import 'package:akounter/data.dart';
import 'package:akounter/enums/dress_size_enum.dart';
import 'package:akounter/locator.dart';
import 'package:akounter/models/entry_model.dart';
import 'package:akounter/models/student_model.dart';
import 'package:akounter/provider/entry_provider.dart';
import 'package:akounter/provider/student_provider.dart';
import 'package:flutter/foundation.dart';

//! may refactor it later

class AddEntryProvider extends ChangeNotifier {
  static int _total = 0, _subtotal = 0, _pending = 0, _amountGiven;
  static String _reason = "Monthly", _detailedReason, _invoiceNo;

  var _student = locator<Data>();

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
    int current = _student.getStudent.fees;

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
    if (_student.getStudent.belt < 8) {
      _detailedReason =
          "${_belts[_student.getStudent.belt]} to ${_belts[_student.getStudent.belt + 1]}";
      updateAsExam(_student.getStudent.belt);
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
        if (_student.getBranch.indirectPayment) _reason += "($_invoiceNo)";
        break;
      case 'Equipments':
        _detailedReason = detailEquipment();
        break;
      case 'Dress':
        _detailedReason = detailDress();
        break;
      case 'Card':
        _detailedReason = "Card";
        break;
    }

    _pending = _amountGiven - _total;
  }

  void postSave(String date) {
    if (_pending != _student.getStudent.pending) {
      _student.getStudent.pending = _pending;
    }
    if (_reason.startsWith("Monthly")) {
      int newFees = _student.getStudent.fees;
      newFees = (newFees + _totalMonth) % 12;
      _student.getStudent.fees = newFees;
      _student.getStudent.lastFees = date;
    } else if (_reason == "Examination") {
      _student.getStudent.belt++;
    }
    StudentProvider()
        .updateStudent(_student.getStudent, _student.getStudent.id);
  }

  //
  // delete
  //
  void delete(EntryModel entry) {
    StudentModel _studentmod = _student.getStudent;
    if (entry.reason.startsWith("Monthly")) {
      List list = entry.detailedReason.split(", ");
      _studentmod.fees -= list.length;
    } else if (entry.reason == "Examination") {
      _studentmod.belt--;
    }
    StudentProvider().updateStudent(_studentmod, _studentmod.id);
    EntryProvider().removeEntry(entry.id);
  }

  // update
  void updateTotal() {
    _total = _subtotal - _pending;
    notifyListeners();
  }
}
