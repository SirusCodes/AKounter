class RequirementModel {
  String id, studentId, studentName, requirementType, dressSize;
  bool issued;
  RequirementModel({
    this.id,
    this.requirementType,
    this.studentId,
    this.studentName,
    this.issued,
    this.dressSize,
  });

  RequirementModel.fromJson(Map snapshot, String id)
      : id = id ?? '',
        requirementType = snapshot["requirement_type"] ?? "",
        studentId = snapshot["student_id"],
        studentName = snapshot["student_name"],
        issued = snapshot["issued"],
        dressSize = snapshot["dress_size"];

  toJson() {
    return {
      "requirement_type": requirementType,
      "student_id": studentId,
      "student_name": studentName,
      "issued": issued,
      "dress_size": dressSize,
    };
  }
}
