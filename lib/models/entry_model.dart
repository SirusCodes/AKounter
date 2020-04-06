class EntryModel {
  String id, reason, detailedReason, date, name, branch;
  int total, subtotal, pending;

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
  });

  EntryModel.fromJson(Map snapshot, String id)
      : this.id = id,
        reason = snapshot["reason"],
        detailedReason = snapshot["detailed_reason"],
        date = snapshot["date"],
        total = snapshot["total"],
        subtotal = snapshot["subtotal"],
        pending = snapshot["pending"],
        name = snapshot['name'],
        branch = snapshot['branch'];

  toJson() {
    return {
      "reason": reason,
      "detailed_reason": detailedReason,
      "date": date,
      "total": total,
      "subtotal": subtotal,
      "pending": pending,
      "name": name,
      "branch": branch,
    };
  }
}
