class StudentModel {
  String id;
  String name;
  String dob;
  String number;
  bool isMember;
  bool onTrial;
  String gender;
  int belt;
  int fees;
  int pending;

  StudentModel({
    this.id,
    this.name,
    this.dob,
    this.number,
    this.isMember,
    this.onTrial,
    this.gender,
    this.belt,
    this.fees,
    this.pending,
  });

  StudentModel.fromJson(Map snapshot, String id)
      : id = id ?? '',
        name = snapshot["name"] ?? "",
        dob = snapshot["dob"] ?? "",
        number = snapshot["number"] ?? "",
        isMember = snapshot["is_member"] ?? false,
        onTrial = snapshot["on_trial"] ?? false,
        gender = snapshot["gender"] ?? "Male",
        belt = snapshot["belt"] ?? 0,
        fees = snapshot["fees"] ?? 0,
        pending = snapshot["pending"] ?? 0;

  toJson() {
    return {
      "name": name,
      "dob": dob,
      "number": number,
      "is_member": isMember,
      "on_trial": onTrial,
      "gender": gender,
      "belt": belt,
      "fees": fees,
      "pending": pending,
    };
  }
}
