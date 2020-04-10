import 'package:akounter/locator.dart';
import 'package:akounter/models/branch_model.dart';
import 'package:akounter/models/user.dart';
import 'package:akounter/provider/branch_provider.dart';
import 'package:akounter/widgets/c_textformfield.dart';
import 'package:akounter/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data.dart';

class AddBranch extends StatefulWidget {
  const AddBranch({Key key, this.branch}) : super(key: key);
  final BranchModel branch;
  @override
  _AddBranchState createState() => _AddBranchState();
}

class _AddBranchState extends State<AddBranch> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _belowGreen = TextEditingController();
  TextEditingController _aboveGreen = TextEditingController();
  TextEditingController _member = TextEditingController();

  static User _data = locator<Data>().getUser;
  bool _indirectCheck = false;
  BranchModel _model = BranchModel(
    owner: _data.mailID,
    instructors: [_data.mailID],
    instructorNames: [_data.displayName],
  );
  @override
  void initState() {
    if (widget.branch.id != null) {
      _model = widget.branch;
      _model.id = _model.id.toString();
      _nameController.text = _model.name;
      _belowGreen.text = _model.belowGreen.toString();
      _aboveGreen.text = _model.aboveGreen.toString();
      _member.text = _model.memberDiscount.toString();
      _indirectCheck = _model.indirectPayment;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _branch = Provider.of<BranchProvider>(context);
    const _padding = const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Branch"),
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
                      hint: "Name",
                      keyboardType: TextInputType.text,
                      label: "Name",
                      textCapitalization: TextCapitalization.words,
                      controller: _nameController,
                      validator: (value) =>
                          _isEmpty(value) ? "Name can't be empty!" : null,
                      onSaved: (value) {
                        _model.name = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: CTextFormField(
                        hint: "400",
                        keyboardType: TextInputType.number,
                        label: "Below Green",
                        controller: _belowGreen,
                        validator: (value) =>
                            _isEmpty(value) ? "Value can't be empty!" : null,
                        onSaved: (value) =>
                            _model.belowGreen = int.parse(value)),
                  ),
                  Padding(
                    padding: _padding,
                    child: CTextFormField(
                        hint: "500",
                        keyboardType: TextInputType.number,
                        label: "Above Green",
                        controller: _aboveGreen,
                        validator: (value) =>
                            _isEmpty(value) ? "Value can't be empty!" : null,
                        onSaved: (value) =>
                            _model.aboveGreen = int.parse(value)),
                  ),
                  Padding(
                    padding: _padding,
                    child: CTextFormField(
                        hint: "50",
                        keyboardType: TextInputType.number,
                        label: "Member Discount",
                        controller: _member,
                        validator: (value) =>
                            _isEmpty(value) ? "Value can't be empty!" : null,
                        onSaved: (value) =>
                            _model.memberDiscount = int.parse(value)),
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
                        "Indirect Payment   ",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600),
                      )
                    ],
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
          _model.indirectPayment = _indirectCheck;

          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            debugPrint("Saved");
            if (_model.id == null)
              _branch.addBranch(_model);
            else
              _branch.updateBranch(_model, _model.id);
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
      _aboveGreen.clear();
      _belowGreen.clear();
      _member.clear();
      _indirectCheck = false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _aboveGreen.dispose();
    _belowGreen.dispose();
    _member.dispose();
    super.dispose();
  }
}
