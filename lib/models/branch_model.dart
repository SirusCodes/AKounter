class BranchModel {
  String id;
  String name;
  int aboveGreen;
  int belowGreen;
  int memberDiscount;
  bool indirectPayment;

  BranchModel({
    this.id,
    this.aboveGreen,
    this.name,
    this.belowGreen,
    this.indirectPayment,
    this.memberDiscount,
  });

  BranchModel.fromMap(Map snapshot, String id)
      : id = id ?? '',
        name = snapshot['name'] ?? '',
        aboveGreen = snapshot['above_green'] ?? 0,
        belowGreen = snapshot['below_green'] ?? 0,
        memberDiscount = snapshot['member_discount'] ?? 0,
        indirectPayment = snapshot['indirect_payment'] ?? false;

  toJson() {
    return {
      "name": name,
      "above_green": aboveGreen,
      "below_green": belowGreen,
      "member_discount": memberDiscount,
      "indirect_payment": indirectPayment,
    };
  }
}
