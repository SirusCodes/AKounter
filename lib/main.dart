import 'package:akounter/provider/database_manager.dart';
import 'package:akounter/locator.dart';
import 'package:akounter/provider/branch_provider.dart';
import 'package:akounter/provider/entry_provider.dart';
import 'package:akounter/provider/login_provider.dart';
import 'package:akounter/provider/requirement_provider.dart';
import 'package:akounter/provider/student_provider.dart';
import 'package:akounter/widgets/auth_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'provider/add_entry_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<BranchProvider>(create: (_) => BranchProvider()),
        Provider<StudentProvider>(create: (_) => StudentProvider()),
        Provider<LoginProvider>(create: (_) => LoginProvider()),
        Provider<EntryProvider>(create: (_) => EntryProvider()),
        ChangeNotifierProvider<AddEntryProvider>(
            create: (_) => AddEntryProvider()),
        ChangeNotifierProvider<DatabaseManager>(
          create: (_) => DatabaseManager(),
        ),
        Provider<RequirementProvider>(create: (_) => RequirementProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AKounter',
        theme: ThemeData(
          accentColor: Colors.black,
          primaryColor: Colors.white,
          splashColor: Colors.black26,
          cardTheme: CardTheme(elevation: 3.0),
          textTheme: TextTheme(
            headline4: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
            headline3: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        home: AuthWidget(),
      ),
    );
  }
}
