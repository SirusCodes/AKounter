import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'locator.dart';
import 'provider/add_entry_provider.dart';
import 'provider/branch_provider.dart';
import 'provider/database_manager.dart';
import 'provider/entry_provider.dart';
import 'provider/login_provider.dart';
import 'provider/requirement_provider.dart';
import 'provider/student_provider.dart';
import 'widgets/auth_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setup();
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.grey[100],
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
          primaryColor: Colors.red[800],
          splashColor: Colors.black26,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: 5.0,
            backgroundColor: Colors.grey[100],
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.blue[800],
          ),
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
