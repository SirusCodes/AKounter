import 'package:akounter/models/requirements_model.dart';
import 'package:akounter/provider/requirement_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentRequirementsList extends StatelessWidget {
  const StudentRequirementsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _req = Provider.of<RequirementProvider>(context);
    List<RequirementModel> _reqList = List<RequirementModel>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Requirements"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: _req.fetchRequirementsAsStreamIssued(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              _reqList = snapshot.data.docs
                  .map((f) => RequirementModel.fromJson(f.data(), f.id))
                  .toList();
            }
            return ListView.builder(
              itemCount: _reqList.length,
              itemBuilder: (context, int i) {
                return Card(
                  elevation: 3.0,
                  child: ListTile(
                    title: Text(_reqList[i].requirementType),
                    subtitle: Text("Issued on: " + _reqList[i].issuedDate),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
