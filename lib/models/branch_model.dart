class BranchModel {
  String id;
  String name;
  int aboveGreen;
  int belowGreen;
  int memberDiscount;
  bool indirectPayment;
  List instructors;
  List instructorNames;
  String owner;
  Map<String, dynamic> requirements;

  BranchModel({
    this.id,
    this.aboveGreen,
    this.name,
    this.belowGreen,
    this.indirectPayment,
    this.memberDiscount,
    this.instructors,
    this.instructorNames,
    this.owner,
    this.requirements,
  });

  BranchModel.fromJson(Map<String, dynamic> snapshot, String id)
      : id = id ?? '',
        name = snapshot['name'] ?? '',
        aboveGreen = snapshot['above_green'] ?? 0,
        belowGreen = snapshot['below_green'] ?? 0,
        memberDiscount = snapshot['member_discount'] ?? 0,
        indirectPayment = snapshot['indirect_payment'] ?? false,
        instructors = snapshot['instructors'] ?? [],
        instructorNames = snapshot['instructor_names'] ?? [],
        owner = snapshot['owner'] ?? "no owner",
        requirements = snapshot["requirements"] ?? {};

  toJson() {
    return {
      "name": name,
      "above_green": aboveGreen,
      "below_green": belowGreen,
      "member_discount": memberDiscount,
      "indirect_payment": indirectPayment,
      "instructors": instructors,
      "instructor_names": instructorNames,
      "owner": owner,
      "requirements": requirements,
    };
  }
}
