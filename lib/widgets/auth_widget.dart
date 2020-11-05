import 'package:akounter/locator.dart';
import 'package:akounter/models/user.dart';
import 'package:akounter/provider/login_provider.dart';
import 'package:akounter/screens/branch_screen.dart';
import 'package:akounter/screens/settings/user_setting_screen.dart';
import 'package:akounter/widgets/navigation_widget.dart';
import 'package:akounter/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data.dart';

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
    return StreamBuilder<User>(
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
