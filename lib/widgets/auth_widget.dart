import 'package:akounter/models/user.dart';
import 'package:akounter/provider/login_provider.dart';
import 'package:akounter/screens/branch_screen.dart';
import 'package:akounter/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<LoginProvider>(context, listen: false);
    return StreamBuilder<User>(
      stream: _auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          return user != null ? BranchScreen() : Login();
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
