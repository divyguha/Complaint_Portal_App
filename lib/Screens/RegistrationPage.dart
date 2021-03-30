import 'package:complaint_portal_app/Components/Alart.dart';
import 'package:complaint_portal_app/Components/BottomBar.dart';
import 'package:complaint_portal_app/Utility/Constraints.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  static String id = 'Registration Page';
  final textFieldctrl = TextEditingController();
  final String type;

  RegistrationPage({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email;
    String pass1, pass2;
    String contact;
    String name;
    final RegistrationPage args = ModalRoute.of(context).settings.arguments;
    Future<dynamic> alartbox(String s) {
      return showDialog(
        context: context,
        builder: (context) {
          return Alart(
            content: s,
          );
        },
      );
    }

    // CollectionReference users = FirebaseFirestore.instance.collection('users');
    Future<void> addUser() {
      return FirebaseFirestore.instance
          .collection(args.type)
          .doc(email)
          .set(
            {
              'Full Name': name,
              'Email': email,
              'Contact': contact,
              'Password': pass1
            },
          )
          .then((value) => Navigator.pop(context, 'Sucessfully Created'))
          .catchError(
            (error) => showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  return AlertDialog(
                    title: Icon(Icons.close_sharp),
                    content: Text(error),
                  );
                }),
          );
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter Full Name'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
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
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        contact = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter Mobile Number',
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {
                        pass1 = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter Password',
                      ),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {
                        pass2 = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Re-Enter Passward'),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        if (email == null)
                          await alartbox('Enter Email ID');
                        else if (name == null)
                          await alartbox('Enter Name');
                        else if (contact == null || contact.length != 10)
                          await alartbox('Enter 10 Digit Contect Number ');
                        else if (pass1 == pass2) {
                          try {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: LinearProgressIndicator(),
                              ),
                            );
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: pass1);
                            addUser();
                            print('Sucess');
                          } catch (e) {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) {
                                return Alart(
                                  content: e.toString(),
                                );
                              },
                            );
                            // Navigator.pop(context, 'Try Again');
                            print(e);
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Alart(
                                content: 'Passward Mismatch',
                              );
                            },
                          );
                        }
                      },
                      icon: Icon(Icons.login),
                      label: Text('Create Account'),
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
