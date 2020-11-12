import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';

extension ConvertToTimestamp on DateTime {
  Timestamp toTimestamp() {
    final datestr = DateFormat("yyyy-MM-dd").format(this);
    print(this.toString());
    final date = DateTime.parse(datestr);

    return Timestamp.fromDate(date);
  }
}
