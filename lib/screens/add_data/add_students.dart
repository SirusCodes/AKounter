import 'package:akounter/widgets/c_textformfield.dart';
import 'package:date_format/date_format.dart';
import 'package:date_text_input_formatter/date_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

enum Gender { male, female }

class AddStudent extends StatefulWidget {
  const AddStudent({Key key}) : super(key: key);

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _numController = TextEditingController();

  bool _indirectCheck;

  Gender _gender = Gender.male;

  double _sliderBelt, _sliderMonth;

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
    _indirectCheck = false;
    _sliderBelt = 0.0;
    _sliderMonth = (DateTime.now().month - 1).ceilToDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                                    date, ["dd", "-", "mm", "-", "yyyy"]);
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
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Checkbox(
                        onChanged: (bool value) {
                          setState(() {
                            _indirectCheck = value;
                          });
                        },
                        value: _indirectCheck,
                      ),
                      Text(
                        "Is Member   ",
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
                          divisions: 12,
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
    setState(() {
      _nameController.clear();
      _numController.clear();
      _dobController.clear();
      _indirectCheck = false;
      _sliderBelt = 0.0;
      _sliderMonth = (DateTime.now().month - 1).ceilToDouble();
      _gender = Gender.male;
    });
  }

  _save() {
    // TODO: Add provider after completing ui
  }
  @override
  void dispose() {
    _nameController.dispose();
    _numController.dispose();
    _dobController.dispose();
    super.dispose();
  }
}
