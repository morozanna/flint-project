import 'package:firebase_core/firebase_core.dart';
import 'package:flint_project/screens/wishesScreen.dart';
import 'package:flint_project/utils/auth/authService.dart';
import 'package:flint_project/utils/services/historyService.dart';
import 'package:flint_project/utils/services/wishService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(); //TODO: add error screen
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => WishService(),
              ),
              ChangeNotifierProvider(
                create: (context) => HistoryService(),
              ),
              ChangeNotifierProvider(
                create: (context) => Authentication(),
              )
            ],
            child: MaterialApp(
              title: 'Wishes App',
              theme: ThemeData(
                  brightness: Brightness.dark,
                  primarySwatch: Colors.deepPurple,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  textTheme: TextTheme(
                    headline1:
                        TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                    bodyText1: TextStyle(
                      fontSize: 20,
                    ),
                  )),
              home: WishesScreen(),
            ),
          );
        }
        return Container(); //TODO: add loading screen
      },
    );
  }
}
