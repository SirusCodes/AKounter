import 'models/branch_model.dart';
import 'models/student_model.dart';
import 'models/user_model.dart';

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

  StudentModel get getStudent => _student ?? StudentModel();

  static UserModel _user;
  set setUser(UserModel user) {
    _user = user;
  }

  UserModel get getUser => _user;
}
