import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_portal_app/Utility/Constraints.dart';
// import 'package:complaint_portal_app/Components/Alart.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class Sheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String referance;
    String ans = 'Error';
    var ft = TextEditingController();
    var db = FirebaseFirestore.instance;
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.resolveWith((states) => Colors.white),
        overlayColor: MaterialStateProperty.resolveWith(
          (states) => Colors.green[200],
        ),
      ),
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Color(0xff6d6d6d),
          context: context,
          builder: (context) {
            return SingleChildScrollView(
                          child: Container(
                // color: Colors.green,
                margin: EdgeInsets.all(30),
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                        controller: ft,
                        autofocus: true,
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecoration.copyWith(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            borderSide: BorderSide(
                                color: Colors.green, style: BorderStyle.solid),
                          ),
                          hintText: 'Enter Referance Number here ',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        onChanged: (value) {
                          referance = value;
                        },
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          bool x = false;
                          var result;
                          showDialog(
                            context: context,
                            builder: (context) => Container(
                              child: Center(
                                child: LoadingDoubleFlipping.square(
                                  backgroundColor: Colors.lightBlueAccent,
                                ),
                              ),
                            ),
                          );
                          try {
                            result = await db
                                .collection('Complaints')
                                .doc(referance)
                                .get();
                            ans = result.data()['Status'];
                          } catch (e) {
                            try {
                              print('IN');
                              result = await db
                                  .collection('Solved')
                                  .doc(referance)
                                  .get();
                              ans = result.data()['Status'];
                              print(result.data());
                              x = true;
                              print('OUT');
                            } catch (e) {
                              ans = 'Not Found';
                              print(e);
                            }
                          }
                          ft.clear();
                          if (x == true) ans += (' on ${result.data()['Date']}');
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Status'),
                                content: Text(ans),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.search, color: Colors.black),
                        label: Text(
                          'Check Status',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Icon(Icons.search, color: Colors.black),
    );
  }
}
