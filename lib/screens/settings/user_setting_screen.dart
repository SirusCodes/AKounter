import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../../data.dart';
import '../../locator.dart';
import '../../provider/login_provider.dart';

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
      body: ListView(
        children: <Widget>[
          Card(
            elevation: 3.0,
            child: ListTile(
              leading: Icon(Icons.share),
              title: Text("Share my E-Mail ID"),
              onTap: () {
                final RenderBox box = context.findRenderObject();
                Share.share(locator<Data>().getUser.mailID,
                    sharePositionOrigin:
                        box.localToGlobal(Offset.zero) & box.size);
              },
            ),
          ),
          Card(
            elevation: 3.0,
            child: ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Sign Out (${locator<Data>().getUser.mailID})"),
              onTap: () {
                _auth.signOutGoogle();
              },
            ),
          ),
        ],
      ),
    );
  }
}
