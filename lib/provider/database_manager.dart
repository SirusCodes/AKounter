import 'dart:io';
import 'package:akounter/models/student_model.dart';
import 'package:akounter/provider/student_provider.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class DatabaseManager extends ChangeNotifier {
  File file;
  List lists;
  StudentProvider _studentProvider = StudentProvider();
  int value;
  int total;
  // static double percent = 0.0;
  // double get getPercent => percent;
  static bool _showIndicator = false;

  set setIndicator(bool value) {
    _showIndicator = value;
  }

  bool get getIndicator => _showIndicator;

  DatabaseManager();
  DatabaseManager.upload() {
    _getFile();
    value = 0;
  }
  _getFile() async {
    file = await FilePicker.getFile(
        type: FileType.custom, allowedExtensions: ["csv"]);
    if (file != null)
      _convertCsv();
    else {
      _showIndicator = false;
      notifyListeners();
    }
  }

  _convertCsv() async {
    String data = await file.readAsString();
    lists = CsvToListConverter(shouldParseNumbers: true).convert(data);
    total = lists.length;
    _upload();
  }

  _upload() {
    List<StudentModel> uList = [];
    for (var list in lists) {
      uList.add(StudentModel(
        name: list[0],
        dob: list[1],
        number: list[2].toString(),
        fatherNum: list[3].toString(),
        motherNum: list[4].toString(),
        gender: list[5],
        belt: _getBelt(list[6]),
        fees: list[7],
        isMember: false,
        onTrial: false,
        pending: 0,
      ));
    }
    _studentProvider.transactionStudent(uList);
  }

  int _getBelt(String belt) {
    int num;
    switch (belt) {
      case "White":
        num = 0;
        break;
      case 'Orange':
        num = 1;
        break;
      case 'Yellow':
        num = 2;
        break;
      case 'Green':
        num = 3;
        break;
      case 'Blue':
        num = 4;
        break;
      case 'Purple':
        num = 5;
        break;
      case 'Brown 3':
        num = 6;
        break;
      case 'Brown 2':
        num = 7;
        break;
      case 'Brown 1':
        num = 8;
        break;
      case 'Black':
        num = 9;
        break;
    }
    return num;
  }

  int _getFees(list) {
    int num;
    switch (list) {
      case "january":
        num = 0;
        break;
      case 'febuary':
        num = 1;
        break;
      case 'march':
        num = 2;
        break;
      case 'april':
        num = 3;
        break;
      case 'may':
        num = 4;
        break;
      case 'June':
        num = 5;
        break;
      case 'July':
        num = 6;
        break;
      case 'August':
        num = 7;
        break;
      case 'September':
        num = 8;
        break;
      case 'October':
        num = 9;
        break;
      case 'November':
        num = 10;
        break;
      case 'December':
        num = 11;
        break;
    }
    return num;
  }
}
