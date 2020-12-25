import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../locator.dart';
import '../models/user_model.dart';
import '../provider/login_provider.dart';
import '../screens/branch_screen.dart';
import '../screens/login_screen.dart';
import '../screens/settings/user_setting_screen.dart';
import 'navigation_widget.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final itemList = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Branch",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: "Settings",
      )
    ];

    final screenList = [BranchScreen(), UserSettingScreen()];

    final _auth = Provider.of<LoginProvider>(context, listen: false);
    return StreamBuilder<UserModel>(
      stream: _auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user != null) {
            locator<Data>().setUser = user;
            return NavigationWidget(
              itemList: itemList,
              screenList: screenList,
            );
          }
          return Login();
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
