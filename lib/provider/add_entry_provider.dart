import 'package:akounter/data.dart';
import 'package:akounter/enums/dress_size_enum.dart';
import 'package:akounter/locator.dart';
import 'package:flutter/foundation.dart';

//! may refactor it later

class AddEntryProvider extends ChangeNotifier {
  static int _total = 0, _subtotal = 0, _pending = 0, _amountGiven;
  static String _reason, _detailedReason, _invoiceNo;

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
    if (reason == "Examination") {
      examination();
    }
  }

  String get detailedReason => _detailedReason;

  //
  // monthy
  //
  void monthly(int perMonth, int totalMonth) {
    _subtotal = perMonth * totalMonth;
    updateAsMonthly(totalMonth);
    updateTotal();
    print(_subtotal);
  }

  updateAsMonthly(int totalM) {
    _detailedReason = "";
    int current = 10;
    while (totalM > 0) {
      _detailedReason +=
          totalM != 1 ? _months[++current] + ", " : _months[++current];
      // -1 so in next iteration it will be 0
      if (current == 11) current = -1;
      totalM--;
    }
    _reason += _student.getBranch.indirectPayment ? "($_invoiceNo)" : "";
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
    List<String> equip = [];
    _detailedReason = "";
    if (_gloves) {
      _subtotal += 450;
      equip.add("Gloves");
    }
    if (_kickpad) {
      _subtotal += 550;
      equip.add("Kickpad");
    }
    if (_chestguard) {
      _subtotal += 750;
      equip.add("Chestguard");
    }
    if (_footguard) {
      _subtotal += 850;
      equip.add("Footguard");
    }

    _detailedReason = equip.toString();
    _detailedReason = _detailedReason.substring(1, _detailedReason.length - 1);

    updateTotal();
  }

  //
  // dress
  //
  DressSP _dressSP = DressSP.none;
  int _size;
  set setSP(DressSP sp) {
    _dressSP = sp;
    dress(_size);
  }

  set setSize(int size) {
    _size = size;
    dress(size);
  }

  void dress(int size) {
    if (size > 11 && size < 25) _subtotal = updateAsDress(size);
    _detailedReason = _size.toString() + " ";
    if (_dressSP == DressSP.sp) {
      _subtotal += 30;
      _detailedReason += "SP";
    }
    if (_dressSP == DressSP.vsp) {
      _subtotal += 60;
      _detailedReason += "VSP";
    }
    if (_dressSP == DressSP.vvsp) {
      _subtotal += 120;
      _detailedReason += "VVSP";
    }
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

  // update
  void updateTotal() {
    _total = _subtotal - _pending;
    notifyListeners();
  }
}
