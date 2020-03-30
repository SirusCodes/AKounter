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
  });

  StudentModel.fromJson(Map snapshot, String id)
      : id = id ?? '',
        name = snapshot["name"],
        dob = snapshot["dob"],
        number = snapshot["number"],
        isMember = snapshot["is_member"],
        onTrial = snapshot["on_trial"],
        gender = snapshot["gender"],
        belt = snapshot["belt"],
        fees = snapshot["fees"];

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
    };
  }
}
