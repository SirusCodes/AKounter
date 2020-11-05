import 'package:akounter/data.dart';
import 'package:akounter/locator.dart';
import 'package:akounter/screens/requirements/requirements_list.dart';
import 'package:flutter/material.dart';

class BranchRequirements extends StatelessWidget {
  final _branch = locator<Data>().getBranch;
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(_branch.name + " requirements"),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _rowReqCards(
              _size,
              context,
              type1: "Gloves",
              type2: "Kickpad",
            ),
            SizedBox(height: 20.0),
            _rowReqCards(
              _size,
              context,
              type1: "Chestguard",
              type2: "Footguard",
            ),
            SizedBox(height: 20.0),
            _requirementCards(_size, "Dress", context),
          ],
        ),
      ),
    );
  }

  Row _rowReqCards(
    Size size,
    BuildContext context, {
    String type1,
    String type2,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _requirementCards(size, type1, context),
        _requirementCards(size, type2, context),
      ],
    );
  }

  Widget _requirementCards(Size size, String type, BuildContext context) {
    return RaisedButton(
      child: SizedBox(
        height: size.width / 3,
        width: size.width / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              type,
              style: Theme.of(context).textTheme.headline3,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              _branch.requirements[type].toString(),
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(fontSize: size.width / 7),
            ),
          ],
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RequirementsList(
              equip: type,
            ),
          ),
        );
      },
    );
  }
}
