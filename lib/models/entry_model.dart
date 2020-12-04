import 'package:cloud_firestore/cloud_firestore.dart';
import '../extensions/date_extention.dart';

class EntryModel {
  String id, reason, detailedReason, name, branch, studentID, requirementID;
  int total, subtotal, pending;
  DateTime date;
  List<DateTime> monthsPaid;

  EntryModel({
    this.id,
    this.reason,
    this.detailedReason,
    this.date,
    this.total,
    this.subtotal,
    this.pending,
    this.name,
    this.branch,
    this.studentID,
    this.requirementID,
    this.monthsPaid,
  });

  EntryModel.fromJson(Map snapshot, String id)
      : this.id = id,
        reason = snapshot["reason"] ?? "",
        detailedReason = snapshot["detailed_reason"] ?? "",
        date = (snapshot["date"] as Timestamp).toDate(),
        total = snapshot["total"] ?? 0,
        subtotal = snapshot["subtotal"] ?? 0,
        pending = snapshot["pending"] ?? 0,
        name = snapshot['name'] ?? "",
        branch = snapshot['branch'] ?? "",
        studentID = snapshot['student_id'],
        monthsPaid = (snapshot['months_paid'] as List)
            .map((e) => (e as Timestamp).toDate())
            .toList(),
        requirementID = snapshot["requirement_id"];

  toJson() {
    return {
      "reason": reason,
      "detailed_reason": detailedReason,
      "date": date.toTimestamp(),
      "total": total,
      "subtotal": subtotal,
      "pending": pending,
      "name": name,
      "branch": branch,
      "student_id": studentID,
      "months_paid": monthsPaid.map((e) => e.toTimestamp()).toList(),
      "requirement_id": requirementID,
    };
  }
}
