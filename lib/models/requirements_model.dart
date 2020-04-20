class RequirementModel {
  String id, studentId, studentName, requirementType;
  bool issued;
  RequirementModel({
    this.id,
    this.requirementType,
    this.studentId,
    this.studentName,
    this.issued,
  });

  RequirementModel.fromJson(Map snapshot, String id)
      : id = id ?? '',
        requirementType = snapshot["requirement_type"] ?? "",
        studentId = snapshot["student_id"],
        studentName = snapshot["student_name"],
        issued = snapshot["issued"];

  toJson() {
    return {
      "requirement_type": requirementType,
      "student_id": studentId,
      "student_name": studentName,
      "issued": issued,
    };
  }
}
