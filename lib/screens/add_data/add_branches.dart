import 'package:akounter/widgets/c_textformfield.dart';
import 'package:flutter/material.dart';

class AddBranch extends StatefulWidget {
  const AddBranch({Key key}) : super(key: key);

  @override
  _AddBranchState createState() => _AddBranchState();
}

class _AddBranchState extends State<AddBranch> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _belowGreen = TextEditingController();
  TextEditingController _aboveGreen = TextEditingController();
  TextEditingController _member = TextEditingController();

  bool _indirectCheck;

  @override
  void initState() {
    _indirectCheck = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    ),
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
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: CTextFormField(
                      hint: "Member Discount",
                      keyboardType: TextInputType.number,
                      label: "Member Discount",
                      controller: _member,
                      validator: (value) =>
                          _isEmpty(value) ? "Value can't be empty!" : null,
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
      _aboveGreen.clear();
      _belowGreen.clear();
      _member.clear();
      _indirectCheck = false;
    });
  }

  _save() {
    // TODO: Add provider after completing ui
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
