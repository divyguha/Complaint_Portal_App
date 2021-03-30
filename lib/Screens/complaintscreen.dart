import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal_app/Components/Alart.dart';
import 'package:complaint_portal_app/Components/Sheet.dart';
import 'package:complaint_portal_app/Utility/Constraints.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class ComplaintScreen extends StatelessWidget {
  static String id = 'ComplaintScreen';
  final fieldText = TextEditingController();
  final String type;
  ComplaintScreen({Key key, this.type}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ComplaintScreen args = ModalRoute.of(context).settings.arguments;
    final auth = FirebaseAuth.instance;
    // User user = FirebaseAuth.instance.currentUser;
    String complaint;
    String s = 'Verify Your Email First By Click the link sent to your email';
    if (!auth.currentUser.emailVerified) {
      return AlertDialog(
        content: Text('Email Verification Required'),
        elevation: 10.0,
        backgroundColor: Colors.grey[200],
        contentPadding: EdgeInsets.all(20.0),
        actionsPadding: EdgeInsets.all(20.0),
        actions: [
          TextButton(
            onPressed: () async {
              try {
                LoadingBouncingGrid.square();
                await auth.currentUser.sendEmailVerification();
                Navigator.pop(context, s);
              } catch (e) {
                s = e;
              }
              Navigator.pop(context, s);
            },
            child: Text('Revisit With Verification'),
          ),
        ],
      );
    }
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // leading: Sheet(),
          title: Text('Complaint Portal'),
          centerTitle: true,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.logout),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: fieldText,
                  autofocus: true,
                  maxLines: 20,
                  onChanged: (s) {
                    complaint = s;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter Complaint here'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      if (complaint.isEmpty) return;
                      var result = await firestore.collection('Complaints').add(
                        {
                          'Description': complaint,
                          'emailid': auth.currentUser.email,
                          'Catagery': args.type,
                          'Date': (DateTime.now().toString()).substring(0, 11),
                          'Status': 'Submitted'
                        },
                      );
                      print(result.id);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: SelectableText(
                                'Complaint Number : ${result.id}\nSave this for Future Referance',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              title: Text('Submitted Succesfully'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('ok'),
                                ),
                              ],
                            );
                          });
                      fieldText.clear();
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Alart(
                              content: e.toString(),
                            );
                          });
                      print('Error');
                    }
                  },
                  icon: Icon(Icons.support_agent_sharp),
                  label: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Sheet(),
      ),
    );
  }
}

// bottomNavigationBar: BottomAppBar(
//           color: Colors.green[50],
//           notchMargin: 10,
//           elevation: 10,
//           child: TextButton(
//             onPressed: () {
//               showModalBottomSheet(
//                 backgroundColor: Colors.green.shade100,
//                 // isScrollControlled: true,
//                 // barrierColor: Colors.red,
//                 context: context,
//                 builder: (context) {
//                   return Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(20.0),
//                         topRight: Radius.circular(20.0),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//             child: Text('Check Status'),
//           ),
//         ),
