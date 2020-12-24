import 'package:flutter/foundation.dart';

@immutable
class ExcelModel {
  final String name;
  final List<DateTime> dates;
  final int totalPaid;

  ExcelModel(this.name, this.dates, this.totalPaid);

  ExcelModel copyWith({
    String name,
    List<DateTime> dates,
    int totalPaid,
  }) {
    return ExcelModel(
      name ?? this.name,
      dates ?? this.dates,
      totalPaid ?? this.totalPaid,
    );
  }

  @override
  String toString() => 'ExcelModel(name: $name, dates: $dates)';
}
