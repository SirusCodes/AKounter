import 'package:akounter/locator.dart';
import 'package:akounter/models/branch_model.dart';
import 'package:akounter/provider/branch_provider.dart';
import 'package:akounter/widgets/c_textformfield.dart';
import 'package:flutter/material.dart';
import '../../data.dart';

class BranchSettingsScreen extends StatefulWidget {
  const BranchSettingsScreen({Key key}) : super(key: key);

  @override
  _BranchSettingsScreenState createState() => _BranchSettingsScreenState();
}

class _BranchSettingsScreenState extends State<BranchSettingsScreen> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  BranchModel data = locator<Data>().getBranch;
  @override
  Widget build(BuildContext context) {
    List _branchInList = data.instructors;
    List _branchInNameList = data.instructorNames;

    return Scaffold(
      appBar: AppBar(
        title: Text("Branch Settings"),
        elevation: 0.0,
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              CTextFormField(
                label: "Instructor Name",
                controller: _nameController,
              ),
              SizedBox(height: 10.0),
              CTextFormField(
                label: "Instructor ID",
                controller: _idController,
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
                            if (_branchInList.length > 1) {
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
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          _branchInList.add(_idController.text);
          _branchInNameList.add(_nameController.text);

          setState(() {
            data.instructors = _branchInList;
            data.instructorNames = _branchInNameList;
          });

          BranchProvider().updateBranch(data, data.id);

          _idController.clear();
          _nameController.clear();
        },
      ),
    );
  }
}
