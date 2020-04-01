import 'package:akounter/models/branch_model.dart';

import './models/student_model.dart';

class Data {
  static BranchModel _branch;
  set setBranch(BranchModel branch) {
    _branch = branch;
  }

  BranchModel get getBranch => _branch;

  static StudentModel _student;
  set setStudent(StudentModel student) {
    _student = student;
  }

  StudentModel get getStudent => _student;
}
