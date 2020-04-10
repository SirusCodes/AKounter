import 'package:akounter/models/student_model.dart';
import 'package:akounter/provider/student_provider.dart';
import 'package:akounter/widgets/c_textformfield.dart';
import 'package:akounter/widgets/snackbar.dart';
import 'package:date_format/date_format.dart';
import 'package:date_text_input_formatter/date_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

enum Gender { male, female }

class AddStudent extends StatefulWidget {
  const AddStudent({Key key, this.student}) : super(key: key);
  final StudentModel student;
  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _numController = TextEditingController();
  TextEditingController _numMotherController = TextEditingController();
  TextEditingController _numFatherController = TextEditingController();

  bool _memberCheck = false, _onTrial = false;

  Gender _gender = Gender.male;

  double _sliderBelt, _sliderMonth;

  StudentModel _student = StudentModel(pending: 0);
  var _belts = [
    "White",
    "Orange",
    "Yellow",
    "Green",
    "Blue",
    "Purple",
    "Brown 3",
    "Brown 2",
    "Brown 1",
    "Black"
  ];
  var _months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  @override
  void initState() {
    _sliderBelt = 0.0;
    _sliderMonth = (DateTime.now().month - 1).ceilToDouble();
    if (widget.student.id != null) {
      _student = widget.student;
      _update();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _students = Provider.of<StudentProvider>(context);
    const _padding = const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Student"),
        elevation: 0.0,
      ),
      body: SizedBox.expand(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: _padding,
                    child: CTextFormField(
                      hint: "Name Surname",
                      keyboardType: TextInputType.text,
                      label: "Name",
                      textCapitalization: TextCapitalization.words,
                      controller: _nameController,
                      validator: (value) =>
                          _isEmpty(value) ? "Name can't be empty!" : null,
                      onSaved: (value) => _student.name = value,
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          fit: FlexFit.loose,
                          child: CTextFormField(
                            hint: "DD-MM-YYYY",
                            keyboardType: TextInputType.number,
                            label: "DOB",
                            controller: _dobController,
                            inputFormatters: [
                              DateTextInputFormatter(
                                format: ["dd", "mm", "yyyy"],
                              )
                            ],
                            onSaved: (value) => _student.dob = value,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.date_range),
                          onPressed: () => DatePicker.showDatePicker(
                            context,
                            maxTime: DateTime.now(),
                            showTitleActions: true,
                            onConfirm: (DateTime date) {
                              setState(() {
                                _dobController.text = formatDate(
                                    date, ["dd", "/", "mm", "/", "yyyy"]);
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: CTextFormField(
                      hint: "0123456789",
                      keyboardType: TextInputType.phone,
                      label: "Number",
                      controller: _numController,
                      onSaved: (value) => _student.number = value,
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: CTextFormField(
                      hint: "0123456789",
                      keyboardType: TextInputType.phone,
                      label: "Father's Number",
                      controller: _numFatherController,
                      onSaved: (value) => _student.fatherNum = value,
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: CTextFormField(
                      hint: "0123456789",
                      keyboardType: TextInputType.phone,
                      label: "Mother's Number",
                      controller: _numMotherController,
                      onSaved: (value) => _student.motherNum = value,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Checkbox(
                        onChanged: (bool value) {
                          setState(() {
                            _memberCheck = value;
                          });
                        },
                        value: _memberCheck,
                      ),
                      Text(
                        "Is Member",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600),
                      ),
                      Checkbox(
                        onChanged: (bool value) {
                          setState(() {
                            _onTrial = value;
                          });
                        },
                        value: _onTrial,
                      ),
                      Text(
                        "On Trial",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Gender:",
                        style: Theme.of(context).textTheme.display1,
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: Gender.male,
                            groupValue: _gender,
                            onChanged: (Gender value) =>
                                setState(() => _gender = value),
                          ),
                          Text(
                            "Male",
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: Gender.female,
                            groupValue: _gender,
                            onChanged: (Gender value) =>
                                setState(() => _gender = value),
                          ),
                          Text(
                            "Female",
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: _padding.copyWith(left: 0.0, right: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Text(
                            "Belt:",
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ),
                        Slider(
                          label: _belts[_sliderBelt.round()],
                          divisions: 9,
                          value: _sliderBelt,
                          onChanged: (value) {
                            setState(() {
                              _sliderBelt = value;
                            });
                          },
                          min: 0,
                          max: 9,
                          activeColor: Theme.of(context).accentColor,
                          inactiveColor: Theme.of(context).splashColor,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: _padding.copyWith(left: 0.0, right: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Text(
                            "Fees paid till:",
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ),
                        Slider(
                          label: _months[_sliderMonth.round()],
                          divisions: 11,
                          value: _sliderMonth,
                          onChanged: (value) {
                            setState(() {
                              _sliderMonth = value;
                            });
                          },
                          min: 0,
                          max: 11,
                          activeColor: Theme.of(context).accentColor,
                          inactiveColor: Theme.of(context).splashColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        splashColor: Theme.of(context).primaryColor,
        child: Icon(Icons.check),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            debugPrint("Saved");
            _save();
            if (_student.id != null)
              _students.updateStudent(_student, _student.id);
            else
              _students.addStudent(_student);
            _clearAllTFF();
          }
        },
      ),
    );
  }

  bool _isEmpty(value) {
    if (value.toString().isEmpty) {
      return true;
    }
    return false;
  }

  void _clearAllTFF() {
    cSnackBar(
      context,
      message: "${_nameController.text} is added",
    );
    setState(() {
      _nameController.clear();
      _numController.clear();
      _dobController.clear();
      _memberCheck = false;
      _sliderBelt = 0.0;
      _sliderMonth = (DateTime.now().month - 1).ceilToDouble();
      _gender = Gender.male;
    });
  }

  void _save() {
    _student.isMember = _memberCheck;
    _student.onTrial = _onTrial;
    _student.gender = _gender == Gender.male ? "Male" : "Female";
    _student.belt = _sliderBelt.toInt();
    _student.fees = _sliderMonth.toInt();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _update() {
    _nameController.text = _student.name;
    _numController.text = _student.number;
    _dobController.text = _student.dob;
    _memberCheck = _student.isMember;
    _sliderBelt = _student.belt.toDouble();
    _sliderMonth = _student.fees.toDouble();
    _gender = _student.gender == "Male" ? Gender.male : Gender.female;
  }
}
