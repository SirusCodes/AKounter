class StudentModel {
  String id;
  String name;
  String dob;
  String number, motherNum, fatherNum;
  bool isMember;
  bool onTrial;
  String gender;
  int belt;
  int fees;
  int pending;
  String lastFees;

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
    this.lastFees,
    this.fatherNum,
    this.motherNum,
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
        pending = snapshot["pending"] ?? 0,
        lastFees = snapshot["last_fees"] ?? "",
        fatherNum = snapshot["father_num"] ?? "",
        motherNum = snapshot["mother_num"] ?? "";

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
      "last_fees": lastFees,
      "father_num": fatherNum,
      "mother_num": motherNum,
    };
  }
}
