import 'package:complaint_portal_app/Components/BottomBar.dart';
import 'package:complaint_portal_app/Screens/FirstPage.dart';
import 'package:complaint_portal_app/Utility/Constraints.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class PassResetScreen extends StatelessWidget {
  static String id = 'Password Reset Screen';
  @override
  Widget build(BuildContext context) {
    String emailid;
    String str = 'Passward Reset Mail is send to your email id';
    var ctrl = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white60,
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 10,
            shadowColor: Colors.green,
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: ctrl,
                    onChanged: (value) {
                      emailid = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter Your Mail Here'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return LoadingBouncingGrid.circle(
                            backgroundColor: Colors.yellow);
                      },
                    );
                    try {
                      print(emailid);
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: emailid);
                    } catch (e) {
                      str = e.toString();
                      print(e);
                    }
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(str),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, FirstPage.id);
                              },
                              child: Text('ok'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Reset'),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyBottom(),
    );
  }
}

//   Navigator.pop(context);

// },
