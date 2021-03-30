import 'package:complaint_portal_app/Screens/AdminPage.dart';
import 'package:complaint_portal_app/Screens/PassReset.dart';
import 'package:complaint_portal_app/Screens/RegistrationPage.dart';
import 'package:complaint_portal_app/Screens/complaintscreen.dart';
import 'package:complaint_portal_app/Screens/wentwrong.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'Screens/FirstPage.dart';
import 'Screens/LogInPage.dart';
import 'Screens/complaintscreen.dart';
// import 'package:loading_animations/loading_animations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text(
                  'Something went Wrong',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          );
        if (snapshot.connectionState == ConnectionState.done) return MyApp();
        return MaterialApp(
          home: Scaffold(
            body: Scaffold(
              body: LoadingRotating.square(
                borderColor: Colors.cyan,
                borderSize: 3.0,
                size: 30.0,
                backgroundColor: Colors.cyanAccent,
                duration: Duration(milliseconds: 500),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: FirstPage.id,
      routes: {
        FirstPage.id: (context) => FirstPage(),
        LogIN.id: (context) => LogIN(),
        RegistrationPage.id: (context) => RegistrationPage(),
        ComplaintScreen.id: (context) => ComplaintScreen(),
        AdminPage.id: (context) => AdminPage(),
        Wrong.id: (context) => Wrong(),
        PassResetScreen.id: (context) => PassResetScreen(),
      },
    );
  }
}
