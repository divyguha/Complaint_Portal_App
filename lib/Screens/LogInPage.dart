import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal_app/Components/Alart.dart';
import 'package:complaint_portal_app/Components/BottomBar.dart';
import 'package:complaint_portal_app/Screens/AdminPage.dart';
// import 'package:complaint_portal_app/Screens/FirstPage.dart';
import 'package:complaint_portal_app/Screens/PassReset.dart';
// import 'package:complaint_portal_app/Screens/FirstPage.dart';
import 'package:complaint_portal_app/Screens/RegistrationPage.dart';
import 'package:complaint_portal_app/Screens/complaintscreen.dart';
import 'package:complaint_portal_app/Utility/CustomException.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:complaint_portal_app/Utility/Constraints.dart';
import 'package:loading_animations/loading_animations.dart';

class LogIN extends StatelessWidget {
  static String id = 'LogIN';
  final String type;

  LogIN({this.type});
  @override
  Widget build(BuildContext context) {
    var forid = TextEditingController();
    var fortype = TextEditingController();
    final LogIN args = ModalRoute.of(context).settings.arguments;
    final _auth = FirebaseAuth.instance;
    String email;
    String pass;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Image.asset('assets/${args.type}.png'),
                    TextField(
                      controller: forid,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter Email',
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      obscureText: true,
                      controller: fortype,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {
                        pass = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter Passward'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        if (args.type == 'Admin') {
                          String eror = 'Something Went Wrong';
                          try {
                            if (email == null) {
                              {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Text('Enter Mail'),
                                  ),
                                );
                                return;
                              }
                            } else if (pass == null) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Text('Enter Passward'),
                                ),
                              );
                              return;
                            } else if (pass.length < 6) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Text(
                                      'Passward length at least 6 character'),
                                ),
                              );
                              return;
                            }
                            showDialog(
                              context: context,
                              builder: (context) => LoadingJumpingLine.circle(
                                backgroundColor: Colors.blue,
                              ),
                            );
                            var admindata = await FirebaseFirestore.instance
                                .collection('Admin Details')
                                .doc('data')
                                .get();
                            print(admindata.data());
                            if (admindata.data()['Email'] != email) {
                              eror = 'Wrong Email';
                              throw MyExe('Wrong Email');
                            } else if (admindata.data()['Password'] != pass) {
                              eror = 'Wrong Passward';
                              throw MyExe('Wrong Passward');
                            }
                            await _auth.signInWithEmailAndPassword(
                                email: email, password: pass);
                            Navigator.pop(context);
                            Navigator.pushNamed(context, AdminPage.id);
                            forid.clear();
                            fortype.clear();
                            email = '';
                            pass = '';
                          } catch (e) {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(eror),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('ok'))
                                  ],
                                );
                              },
                            );
                            print(e);
                          }
                        } else {
                          try {
                            if (email == null) {
                              {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Text('Enter Mail'),
                                  ),
                                );
                                return;
                              }
                            } else if (pass == null) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Text('Enter Passward'),
                                ),
                              );
                              return;
                            } else if (pass.length < 6) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Text(
                                      'Passward length at least 6 character'),
                                ),
                              );
                              return;
                            }
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: LoadingJumpingLine.circle(
                                  backgroundColor: Colors.lightBlue,
                                ),
                              ),
                            );
                            print(args.type);
                            print(email);
                            var fatchdata = await FirebaseFirestore.instance
                                .collection(args.type)
                                .doc(email)
                                .get();

                            if (fatchdata.data() == null)
                              throw MyExe(
                                  'Dosnt belong here'); //fatching student / teacher data
                            await _auth.signInWithEmailAndPassword(
                                email: email, password: pass);
                            final result = await Navigator.pushNamed(
                              context,
                              ComplaintScreen.id,
                              arguments: ComplaintScreen(
                                type: args.type,
                              ),
                            );
                            Navigator.pop(context);
                            forid.clear();
                            fortype.clear();
                            if (result != null)
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: Text("$result"),
                                  ),
                                );
                          } on MyExe {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) {
                                String rs =
                                    'Did\'nt find your Data in ${args.type} Database';
                                if (email.length == 0)
                                  rs = 'Enter Email';
                                else if (pass.length == 0) rs = 'Enter Pass';
                                return Alart(content: rs);
                              },
                            );
                          } catch (e) {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Alart(content: e.toString());
                              },
                            );
                            print(e);
                          }
                        }
                      },
                      icon: Icon(Icons.login),
                      label: Text('Login'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (args.type != 'Admin')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () async {
                              final result = await Navigator.pushNamed(
                                context,
                                RegistrationPage.id,
                                arguments: RegistrationPage(
                                  type: args.type,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(
                                    SnackBar(content: Text("$result")));
                            },
                            child: Text(
                              'Register Here',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500),
                            ),
                            style: ButtonStyle(
                                // elevation: MaterialStateProperty.resolveWith(
                                //     (states) => 2),
                                // backgroundColor: MaterialStateColor.resolveWith(
                                //     (states) => Colors.white),
                                ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          TextButton(
                              child: Text('Forget Passward'),
                              onPressed: () async {
                                await Navigator.pushNamed(
                                    context, PassResetScreen.id);
                              })
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: MyBottom(),
      ),
    );
  }
}
