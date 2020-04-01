import 'package:akounter/provider/add_entry_provider.dart';
import 'package:akounter/widgets/add_entry_components/dress.dart';
import 'package:akounter/widgets/add_entry_components/equipments.dart';
import 'package:akounter/widgets/add_entry_components/examination.dart';
import 'package:akounter/widgets/add_entry_components/monthly.dart';
import 'package:akounter/widgets/add_entry_components/others.dart';
import 'package:akounter/widgets/c_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:akounter/enums/type_payment_enum.dart';
import 'package:provider/provider.dart';
import '../../data.dart';
import '../../locator.dart';

class AddEntry extends StatefulWidget {
  AddEntry({Key key}) : super(key: key);
  @override
  _AddEntryState createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
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

  @override
  void initState() {
    _entry.setPending = _student.getStudent.pending;

    if (_student.getStudent.belt <= 3)
      _entry.setSubtotal = _student.getBranch.belowGreen;
    else
      _entry.setSubtotal = _student.getBranch.aboveGreen;

    _reason = _reasons[0];
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
        child: Container(
          color: Theme.of(context).primaryColor,
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
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  "Total:   ${_entry.getTotal}",
                                  style: Theme.of(context).textTheme.display2,
                                ),
                              ),
                              Text("Subtotal:   ${_entry.getSubtotal}"),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Pending:   ${_entry.getPending}"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: CTextFormField(
                                  label: "Amount given",
                                  hint: "1000",
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value == "") {
                                      return "Enter a defined value";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    _entry.setAmountGiven = int.parse(value);
                                  },
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
      ),
    );
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
