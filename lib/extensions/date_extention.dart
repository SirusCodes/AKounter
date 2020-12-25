import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ConvertToTimestamp on DateTime {
  Timestamp toTimestamp() => Timestamp.fromDate(
        DateTime.parse(DateFormat("yyyy-MM-dd").format(this)),
      );
}

extension CopyWithDate on DateTime {
  DateTime copyWith({year, month, day}) => DateTime(
        year ?? this.year,
        month ?? this.month,
        day ?? this.day,
      );
}

extension DateRangeList on DateTimeRange {
  List<DateTime> toList() {
    List<DateTime> result = [];
    DateTime start = this.start.trimDate();
    DateTime end = this.end.trimDate();

    while (start.compareTo(end) <= 0) {
      result.add(start);
      start = start.copyWith(month: start.month + 1);
    }
    return result;
  }
}

extension FormatDate on DateTime {
  DateTime trimDate() => DateTime(
        this.year,
        this.month,
        1,
      );
}
