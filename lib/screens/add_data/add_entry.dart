import 'package:akounter/widgets/add_entry_components/dress.dart';
import 'package:akounter/widgets/add_entry_components/equipments.dart';
import 'package:akounter/widgets/add_entry_components/examination.dart';
import 'package:akounter/widgets/add_entry_components/monthly.dart';
import 'package:akounter/widgets/add_entry_components/others.dart';
import 'package:flutter/material.dart';
import 'package:akounter/enums/type_payment_enum.dart';

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

  @override
  void initState() {
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
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Total:   ***",
                              style: Theme.of(context).textTheme.display2,
                            ),
                          ),
                          Text("Subtotal:   ***"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Pending:   *"),
                          ),
                        ],
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
    } else {
      return Others();
    }
  }
}
