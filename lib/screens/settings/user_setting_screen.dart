import 'package:akounter/locator.dart';
import 'package:akounter/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import '../../data.dart';

class UserSettingScreen extends StatelessWidget {
  const UserSettingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        elevation: 0.0,
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: <Widget>[
            Card(
              elevation: 3.0,
              child: ListTile(
                leading: Icon(Icons.share),
                title: Text("Send UserID"),
                onTap: () {
                  final RenderBox box = context.findRenderObject();
                  Share.share(locator<Data>().getUser.uid,
                      sharePositionOrigin:
                          box.localToGlobal(Offset.zero) & box.size);
                  print(locator<Data>().getUser.uid);
                },
              ),
            ),
            Card(
              elevation: 3.0,
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Sign Out"),
                onTap: () {
                  _auth.signOutGoogle();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
