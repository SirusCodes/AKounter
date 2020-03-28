import 'package:akounter/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<LoginProvider>(context, listen: false);
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlutterLogo(size: 200),
          SizedBox(height: 100),
          OutlineButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    "assets/google_logo.png",
                    height: 35.0,
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Login with Google",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            splashColor: Colors.blue,
            borderSide: BorderSide(color: Colors.black12, width: 2.0),
            onPressed: () =>
                _user.signInWithGoogle().catchError((e) => print(e)),
          )
        ],
      ),
    );
  }
}
