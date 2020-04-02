class EntryModel {
  String id, reason, detailedReason, date;
  int total, subtotal, pending;

  EntryModel({
    this.id,
    this.reason,
    this.detailedReason,
    this.date,
    this.total,
    this.subtotal,
    this.pending,
  });

  EntryModel.fromJson(Map snapshot, String id)
      : this.id = id,
        reason = snapshot["reason"],
        detailedReason = snapshot["detailed_reason"],
        date = snapshot["date"],
        total = snapshot["total"],
        subtotal = snapshot["subtotal"],
        pending = snapshot["pending"];

  toJson() {
    return {
      "reason": reason,
      "detailed_reason": detailedReason,
      "date": date,
      "total": total,
      "subtotal": subtotal,
      "pending": pending,
    };
  }
}
