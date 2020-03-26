import 'package:akounter/provider/login_provider.dart';
import 'package:akounter/widgets/auth_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}

// const MaterialColor white = const MaterialColor(
//   0xFFFFFFFF,
//   const <int, Color>{
//     50: const Color(0xFFFFFFFF),
//     100: const Color(0xFFFFFFFF),
//     200: const Color(0xFFFFFFFF),
//     300: const Color(0xFFFFFFFF),
//     400: const Color(0xFFFFFFFF),
//     500: const Color(0xFFFFFFFF),
//     600: const Color(0xFFFFFFFF),
//     700: const Color(0xFFFFFFFF),
//     800: const Color(0xFFFFFFFF),
//     900: const Color(0xFFFFFFFF),
//   },
// );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AKounter',
      theme: ThemeData(
        accentColor: Colors.black,
        primaryColor: Colors.white,
        splashColor: Colors.black26,
        textTheme: TextTheme(
          display1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
        ),
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider())
        ],
        child: AuthWidget(),
      ),
    );
  }
}
