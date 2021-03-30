import 'package:complaint_portal_app/Screens/LogInPage.dart';
import 'package:complaint_portal_app/Screens/complaintscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Authenticate {
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ComplaintScreen();}
          else
          return LogIN();
        }
    );
  }
}
