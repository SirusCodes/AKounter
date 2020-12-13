import 'package:flutter/foundation.dart';

@immutable
class ExcelModel {
  final String name;
  final List<DateTime> dates;

  ExcelModel(this.name, this.dates);

  ExcelModel copyWith({
    String name,
    List<DateTime> dates,
  }) {
    return ExcelModel(
      name ?? this.name,
      dates ?? this.dates,
    );
  }

  @override
  String toString() => 'ExcelModel(name: $name, dates: $dates)';
}
