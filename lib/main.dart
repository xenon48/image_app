import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:picturn/Views/login_view.dart';
import 'package:picturn/onboarding.dart';
import 'package:picturn/runtime_data.dart';
import 'Views/CustomWidgets/secondary_splash.dart';
import 'my_shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isFirstRun = true;
  bool stateUpdated = false;

  _MyAppState() {
    checkFirstRun();
  }

  void checkFirstRun() {
    MySharedPreferences.instance
        .getBooleanValue(MySharedPreferences.keyIsFirstRun)
        .then(
          (value) => setState(
            () {
          isFirstRun = value;
          stateUpdated = true;
          if (isFirstRun)
            MySharedPreferences.instance
                .setBooleanValue(MySharedPreferences.keyIsFirstRun, false);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    RuntimeData.currentOpenProfile = null;

    Future<FirebaseApp> firebaseInit = Firebase.initializeApp();
    return MaterialApp(
        title: 'ImageApp',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: FutureBuilder(
            future: firebaseInit,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('Error :"${snapshot.error.toString()}');
                return Container(decoration: BoxDecoration(color: Colors.red));
              } else if (snapshot.hasData) {
                return isFirstRun ? OnboardingRoute() : LoginPage();
              } else {
                return SecondarySplash();
              }
            }));
  }
}