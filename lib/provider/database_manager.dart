import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../locator.dart';
import '../models/entry_model.dart';
import '../models/excel_model.dart';
import '../models/student_model.dart';
import 'entry_provider.dart';
import 'student_provider.dart';
import 'package:csv/csv.dart';
import 'package:date_format/date_format.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../extensions/date_extention.dart';

import '../data.dart';

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
      _convertFromCsv();
    else {
      _showIndicator = false;
      notifyListeners();
    }
  }

  _convertFromCsv() async {
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

  Future<String> saveToCsv(DateTimeRange dateRange) async {
    final dateList = dateRange.toList();

    EntryProvider _entryProvider = EntryProvider();
    final result = await _entryProvider.fetchEntriesBetween(dateList);
    Map<String, ExcelModel> data = {};
    for (final model in result) {
      data.update(
        model.studentID,
        (value) => value.copyWith(dates: [...value.dates, ...model.monthsPaid]),
        ifAbsent: () => data[model.studentID] = ExcelModel(
          model.name,
          model.monthsPaid,
        ),
      );
    }

    List<List> csvList = [_header(dateList)];
    for (final map in data.entries) {
      List<String> row = [map.value.name];
      final dates = map.value.dates;
      for (final date in dateList) {
        if (dates.contains(date))
          row.add("Paid");
        else
          row.add("Not Paid");
      }
      csvList.add(row);
    }

    final branch = locator<Data>().getBranch;

    String convertedCsv = ListToCsvConverter().convert(csvList);
    final start = formatDate(dateRange.start, [MM]);
    final last = formatDate(dateRange.end, [MM]);
    String fileName = "${branch.name}_$start-$last.csv";
    String dirPath = await _checkWritePermissionNGetDirPath();

    if (dirPath != null) {
      File file = File("$dirPath$fileName");
      file.writeAsStringSync(convertedCsv);
      return file.path;
    }
    return null;
  }

  Future<String> _checkWritePermissionNGetDirPath() async {
    final storagePerm = Permission.storage;
    final status = await storagePerm.status;
    if (status.isDenied)
      storagePerm.request();
    else if (status.isGranted || status.isUndetermined) {
      final baseDir = await getExternalStorageDirectory();
      final dirPath = await Directory(
        '${baseDir.path}/${locator<Data>().getBranch.name}/',
      ).create(recursive: true);

      return dirPath.path;
    } else if (status.isPermanentlyDenied) openAppSettings();
  }

  List<String> _header(List<DateTime> dateRange) {
    List<String> headers = ["Name"];
    for (final date in dateRange)
      headers.add(formatDate(date, [MM, "-", yyyy]));
    return headers;
  }

  int _getBelt(String belt) {
    switch (belt) {
      case "White":
        return 0;
      case 'Orange':
        return 1;
      case 'Yellow':
        return 2;
      case 'Green':
        return 3;
      case 'Blue':
        return 4;
      case 'Purple':
        return 5;
      case 'Brown 3':
        return 6;
      case 'Brown 2':
        return 7;
      case 'Brown 1':
        return 8;
      case 'Black':
        return 9;
    }
    return 0;
  }
}
