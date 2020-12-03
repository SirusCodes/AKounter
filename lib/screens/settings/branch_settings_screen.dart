import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data.dart';
import '../../locator.dart';
import '../../models/branch_model.dart';
import '../../models/user_model.dart';
import '../../provider/branch_provider.dart';
import '../../provider/database_manager.dart';
import '../../widgets/c_textformfield.dart';
import '../../widgets/snackbar.dart';

class BranchSettingsScreen extends StatefulWidget {
  const BranchSettingsScreen({Key key}) : super(key: key);

  @override
  _BranchSettingsScreenState createState() => _BranchSettingsScreenState();
}

class _BranchSettingsScreenState extends State<BranchSettingsScreen> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _idController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  BranchModel data = locator<Data>().getBranch;
  UserModel _user = locator<Data>().getUser;

  @override
  Widget build(BuildContext context) {
    List _branchInList = data.instructors;
    List _branchInNameList = data.instructorNames;
    final _databaseManager = Provider.of<DatabaseManager>(context);

    return
        // LoadingOverlay(
        //   isLoading: _databaseManager.getIndicator,
        //   color: Theme.of(context).primaryColor,
        //   opacity: 0.7,
        //   progressIndicator: CircularProgressIndicator(
        //       // value: _databaseManager.getPercent,
        //       ),
        // child:
        Scaffold(
      appBar: AppBar(
        title: Text("Branch Settings"),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.cloud_upload),
            tooltip: "upload to cloud",
            onPressed: () {
              setState(() {
                _databaseManager.setIndicator = true;
              });
              DatabaseManager.upload();
            },
          ),
          IconButton(
            icon: Icon(Icons.cloud_download),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  CTextFormField(
                    label: "Instructor Name",
                    controller: _nameController,
                    validator: (value) {
                      if (value.toString().isEmpty) return "Can't be empty";
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  CTextFormField(
                    label: "Instructor Mail ID",
                    controller: _idController,
                    validator: (value) {
                      if (!EmailValidator.validate(value))
                        return "Incorrect email ID";
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Flexible(
              fit: FlexFit.loose,
              child: ListView.builder(
                itemCount: _branchInList.length,
                itemBuilder: (context, int i) {
                  return Card(
                    elevation: 3.0,
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(_branchInNameList[i]),
                      subtitle: Text(_branchInList[i]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          if (_branchInList.length <= 1 ||
                              data.owner != _user.mailID) {
                            cSnackBar(
                              context,
                              message: "Cannot delete owner account",
                            );
                          } else if (data.owner == _branchInList[i]) {
                            cSnackBar(
                              context,
                              message: "You are not owner of this branch",
                            );
                          } else {
                            cSnackBar(
                              context,
                              message: "${_branchInNameList[i]} is removed",
                            );
                            setState(() {
                              _branchInList.removeAt(i);
                              _branchInNameList.removeAt(i);
                            });

                            data.instructors = _branchInList;
                            data.instructorNames = _branchInNameList;
                            BranchProvider().updateBranch(data, data.id);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Add Instructor"),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            _branchInList.add(_idController.text);
            _branchInNameList.add(_nameController.text);

            setState(() {
              data.instructors = _branchInList;
              data.instructorNames = _branchInNameList;
            });

            BranchProvider().updateBranch(data, data.id);

            _idController.clear();
            _nameController.clear();
          } else if (data.owner == _user.mailID)
            cSnackBar(
              context,
              message: "You are not owner of this branch",
            );
        },
      ),
      // ),
    );
  }
}
