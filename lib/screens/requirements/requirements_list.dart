import '../../models/requirements_model.dart';
import '../../provider/requirement_provider.dart';
import '../../provider/requirements_list_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequirementsList extends StatelessWidget {
  const RequirementsList({Key key, this.equip}) : super(key: key);
  final String equip;
  @override
  Widget build(BuildContext context) {
    final _requirements = Provider.of<RequirementProvider>(context);
    RequirementsListProvider().init();
    List<RequirementModel> _requirementList = [];
    return ChangeNotifierProvider<RequirementsListProvider>(
      create: (_) => RequirementsListProvider(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(equip),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: _requirements.fetchRequirementsAsStream(equip),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                _requirementList = snapshot.data.docs
                    .map((f) => RequirementModel.fromJson(f.data(), f.id))
                    .toList();

                RequirementsListProvider().setList = _requirementList;

                return Consumer<RequirementsListProvider>(
                  builder: (_, list, __) {
                    return ListView.builder(
                      itemCount: _requirementList.length,
                      itemBuilder: (context, int i) {
                        return Card(
                          elevation: 3.0,
                          child: ListTile(
                            title: _requirementList[i].requirementType !=
                                    "Dress"
                                ? Text(_requirementList[i].studentName)
                                : Text(_requirementList[i].studentName +
                                    " (${_requirementList[i].dressSize.trim()})"),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.check_circle,
                                color: list.getColor(i, context),
                              ),
                              onPressed: () => list.changeIssued(i),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        floatingActionButton: Consumer<RequirementsListProvider>(
          builder: (_, check, __) {
            return check.getApply
                ? FloatingActionButton.extended(
                    label: Text("Apply"),
                    icon: Icon(Icons.check),
                    splashColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      check.uploadChanges(equip);
                    },
                  )
                : Container();
          },
        ),
      ),
    );
  }
}
