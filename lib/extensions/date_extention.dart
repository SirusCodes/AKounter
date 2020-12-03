import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';

extension ConvertToTimestamp on DateTime {
  Timestamp toTimestamp() => Timestamp.fromDate(
        DateTime.parse(DateFormat("yyyy-MM-dd").format(this)),
      );
}
