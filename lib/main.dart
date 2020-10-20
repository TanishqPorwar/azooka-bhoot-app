import 'package:bhoot/pages/home_page.dart';
import 'package:bhoot/services/firebase_methods.dart';
import 'package:bhoot/style/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  FirebaseMethods firebaseMethods = FirebaseMethods();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: AppHome(
              firebaseMethods: firebaseMethods,
            ),
          );
        }
        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

class AppHome extends StatefulWidget {
  final FirebaseMethods firebaseMethods;

  const AppHome({Key key, this.firebaseMethods}) : super(key: key);
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  @override
  void initState() {
    super.initState();
    widget.firebaseMethods.signInAnonymously();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: widget.firebaseMethods.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user != null) {
            return HomePage(
              firebaseMethods: widget.firebaseMethods,
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            ),
          );
        }
      },
    );
  }
}
