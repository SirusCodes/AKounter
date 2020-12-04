import 'package:cloud_firestore/cloud_firestore.dart';

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

extension FormatDate on DateTime {
  DateTime trimDate() => DateTime(
        this.year,
        this.month,
        1,
      );
}
