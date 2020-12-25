import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../locator.dart';
import '../models/branch_model.dart';
import '../provider/branch_provider.dart';
import '../widgets/navigation_widget.dart';
import '../widgets/snackbar.dart';
import 'add_data/add_branches.dart';
import 'branch_entry_list.dart';
import 'record_screen.dart';
import 'requirements/branch_requirements.dart';
import 'settings/branch_settings_screen.dart';
import 'student_screen.dart';

class BranchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> _screenList = [
      StudentScreen(),
      BranchEntryList(),
      RecordsScreen(),
      BranchSettingsScreen(),
    ];

    List<BottomNavigationBarItem> _itemList = [
      BottomNavigationBarItem(
        icon: Icon(Icons.people),
        label: "Students",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.library_books),
        label: "Entries",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.file_copy_rounded),
        label: "Records",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: "Settings",
      )
    ];

    List<BranchModel> _branchList;
    final _branches = Provider.of<BranchProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Branches"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Center(child: Text("Tap and hold for branch requirements")),
            Flexible(
              fit: FlexFit.loose,
              child: StreamBuilder(
                stream: _branches.fetchBranchesAsStream(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    _branchList = snapshot.data.docs
                        .map((f) => BranchModel.fromJson(f.data(), f.id))
                        .toList();

                    return ListView.builder(
                      itemCount: _branchList.length,
                      itemBuilder: (context, int i) {
                        return Card(
                          elevation: 3.0,
                          child: ListTile(
                            leading: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AddBranch(branch: _branchList[i]),
                                  ),
                                );
                              },
                            ),
                            title: RichText(
                              text: TextSpan(
                                text: _branchList[i].name + " ",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                                children: <TextSpan>[
                                  if (_branchList[i].owner ==
                                      locator<Data>().getUser.mailID)
                                    TextSpan(
                                        text: "(owner)",
                                        style: TextStyle(fontSize: 12))
                                ],
                              ),
                            ),
                            onTap: () {
                              locator<Data>().setBranch = _branchList[i];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NavigationWidget(
                                    itemList: _itemList,
                                    screenList: _screenList,
                                  ),
                                ),
                              );
                            },
                            onLongPress: () {
                              locator<Data>().setBranch = _branchList[i];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BranchRequirements(),
                                ),
                              );
                            },
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                if (_branchList[i].owner ==
                                    locator<Data>().getUser.mailID) {
                                  cSnackBar(
                                    context,
                                    message:
                                        "Do you really want to delete ${_branchList[i].name}?",
                                    button: FlatButton(
                                      onPressed: () {
                                        _branches
                                            .removeBranch(_branchList[i].id);
                                      },
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  );
                                } else
                                  cSnackBar(
                                    context,
                                    message:
                                        "You are not the owner of this branch",
                                  );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Add Branch"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBranch(
                branch: BranchModel(id: null),
              ),
            ),
          );
        },
      ),
    );
  }
}
