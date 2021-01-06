import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../data.dart';
import '../../enums/type_payment_enum.dart';
import '../../locator.dart';
import '../../models/entry_model.dart';
import '../../provider/add_entry_provider.dart';
import '../../provider/entry_provider.dart';
import '../../widgets/add_entry_components/dress.dart';
import '../../widgets/add_entry_components/equipments.dart';
import '../../widgets/add_entry_components/examination.dart';
import '../../widgets/add_entry_components/monthly.dart';
import '../../widgets/add_entry_components/others.dart';
import '../../widgets/c_textformfield.dart';

class AddEntry extends StatefulWidget {
  AddEntry({Key key}) : super(key: key);
  @override
  _AddEntryState createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  var _formKey = GlobalKey<FormState>();
  List<String> _reasons = [
    'Monthly',
    'Examination',
    'Equipments',
    'Dress',
    'Card',
    'Tournament',
    'Others'
  ];

  String _reason;

  PaymentType _paymentType = PaymentType.monthly;

  var _entry = locator<AddEntryProvider>();
  var _student = locator<Data>();

  DateTime _date;

  @override
  void initState() {
    // set pending to the value from student
    _entry.setPending = _student.getStudent.pending;

    // set monthly price
    if (_student.getStudent.belt < 3)
      _entry.setSubtotal = _student.getBranch.belowGreen;
    else
      _entry.setSubtotal = _student.getBranch.aboveGreen;

    // set reason as first value
    _reason = _reasons[0];
    _entry.setReason = _reason;

    // set value of total month initially
    _entry.setTotalMonth = 1;

    // initialize date
    _date = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Add Entry"),
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: _width,
                  child: Card(
                    elevation: 3.0,
                    child: Consumer<AddEntryProvider>(
                      builder: (_, _entry, __) {
                        return Column(
                          children: <Widget>[
                            OutlineButton(
                              child: Text(
                                formatDate(
                                  _date,
                                  ["dd", "/", "mm", "/", "yyyy"],
                                ),
                              ),
                              onPressed: _showDatePicker,
                            ),
                            Text("Subtotal:   ${_entry.getSubtotal}"),
                            if (_entry.getPending != 0)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _entry.getPending < 0
                                      ? "Balance: ${-_entry.getPending}"
                                      : "Advance: ${_entry.getPending}",
                                ),
                              ),
                            Text(
                              "Total:   ${_entry.getTotal}",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Form(
                              key: _formKey,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: CTextFormField(
                                  label: "Amount given",
                                  hint: "1000",
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) {
                                    if (value == null || value == "") {
                                      return "Please enter a proper value!";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    _entry.setAmountGiven = int.parse(value);
                                  },
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: _width,
                  child: Card(
                    elevation: 3.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: DropdownButton(
                          value: _reason,
                          items: _reasons
                              .map((f) => DropdownMenuItem(
                                    value: f,
                                    child: Text(f),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _reason = value;
                              _changeReasons(value);
                            });
                            _entry.setReason = _reason;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: _width,
                  child: Card(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _typeBlock(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Consumer<AddEntryProvider>(
        builder: (_, _entry, __) {
          final _save = Provider.of<EntryProvider>(context, listen: false);
          return FloatingActionButton.extended(
            label: Text("Save"),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _entry.save();
                _save.addEntry(
                  EntryModel(
                    reason: _entry.getReason,
                    detailedReason: _entry.getDetailedReason,
                    pending: _entry.getPending,
                    total: _entry.getTotal,
                    subtotal: _entry.getSubtotal,
                    date: _date,
                    name: _student.getStudent.name,
                    branch: _student.getBranch.id,
                    studentID: _student.getStudent.id,
                    requirementID: _entry.getReqID,
                    monthsPaid: _entry.getMonthRange,
                  ),
                );
                _entry.postSaveStudent(_date);
                Navigator.pop(context);
              }
            },
          );
        },
      ),
    );
  }

  Future<void> _showDatePicker() async {
    final today = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(today.year, today.month - 1, today.day),
      initialDate: _date,
      lastDate: today,
    );

    if (selectedDate != _date && selectedDate != null) {
      setState(() {
        _date = selectedDate;
      });
    }
  }

  void _changeReasons(String value) {
    switch (value) {
      case "Monthly":
        _paymentType = PaymentType.monthly;
        break;

      case 'Examination':
        _paymentType = PaymentType.examination;
        break;

      case 'Equipments':
        _paymentType = PaymentType.equipments;
        break;

      case 'Dress':
        _paymentType = PaymentType.dress;
        break;

      case 'Card':
        _paymentType = PaymentType.card;
        break;

      case 'Tournament':
        _paymentType = PaymentType.tournament;
        break;

      case "Others":
        _paymentType = PaymentType.others;
        break;
    }
  }

  Widget _typeBlock() {
    if (_paymentType == PaymentType.monthly) {
      return Monthly();
    } else if (_paymentType == PaymentType.examination) {
      return Examination();
    } else if (_paymentType == PaymentType.equipments) {
      return Equipments();
    } else if (_paymentType == PaymentType.dress) {
      return Dress();
    } else if (_paymentType == PaymentType.others) {
      return Others();
    } else {
      return Container();
    }
  }
}
