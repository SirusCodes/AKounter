import 'package:akounter/models/requirements_model.dart';
import 'package:akounter/provider/requirement_provider.dart';
import 'package:akounter/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequirementsList extends StatelessWidget {
  const RequirementsList({Key key, this.equip}) : super(key: key);
  final String equip;
  @override
  Widget build(BuildContext context) {
    final _requirements = Provider.of<RequirementProvider>(context);
    List<RequirementModel> _requirementList = List<RequirementModel>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(equip),
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: _requirements.fetchRequirementsAsStream(equip),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                _requirementList = snapshot.data.documents
                    .map((f) => RequirementModel.fromJson(f.data, f.documentID))
                    .toList();
              }
              return ListView.builder(
                itemCount: _requirementList.length,
                itemBuilder: (context, int i) {
                  return Card(
                    elevation: 3.0,
                    child: ListTile(
                      title: _requirementList[i].requirementType != "Dress"
                          ? Text(_requirementList[i].studentName)
                          : Text(_requirementList[i].studentName +
                              " (${_requirementList[i].dressSize.trim()})"),
                      trailing: IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {},
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
