import 'package:akounter/data.dart';
import 'package:akounter/models/branch_model.dart';
import 'package:akounter/provider/branch_provider.dart';
import 'package:akounter/screens/branch_entry_list.dart';
import 'package:akounter/screens/settings/branch_settings_screen.dart';
import 'package:akounter/widgets/navigation_widget.dart';
import 'package:akounter/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../locator.dart';
import './add_data/add_branches.dart';
import './student_screen.dart';
import 'package:flutter/material.dart';

class BranchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> _screenList = [
      StudentScreen(),
      BranchEntryList(),
      BranchSettingsScreen(),
    ];

    List<BottomNavigationBarItem> _itemList = [
      BottomNavigationBarItem(
        icon: Icon(Icons.people),
        title: Text("Student List"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.library_books),
        title: Text("Entry List"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        title: Text("Branch Settings"),
      )
    ];

    List<BranchModel> _branchList;
    final _branches = Provider.of<BranchProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Branches"),
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: _branches.fetchBranchesAsStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                _branchList = snapshot.data.documents
                    .map((f) => BranchModel.fromJson(f.data, f.documentID))
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
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
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
                                    _branches.removeBranch(_branchList[i].id);
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
                                message: "You are not the owner of this branch",
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
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
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
