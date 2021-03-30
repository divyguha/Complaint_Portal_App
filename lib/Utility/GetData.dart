// import 'package:cloud_firestore/cloud_firestore.dart';

// class Reterive {
//   final _firestore = FirebaseFirestore.instance;
//   void getComplents() async {
//     final msg = await _firestore.collection('complaints').get();
//     for (var i in msg.docs) {
//       print(i.data());
//     }
//   }
// }

import 'package:complaint_portal_app/Components/Alart.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Stream complaintslist = FirebaseFirestore.instance
        .collection('Complaints')
        .snapshots(includeMetadataChanges: true);

    return StreamBuilder<QuerySnapshot>(
      stream: complaintslist,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Something went wrong'),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: LoadingRotating.square(
              borderColor: Colors.cyan,
              borderSize: 3.0,
              size: 30.0,
              backgroundColor: Colors.cyanAccent,
              duration: Duration(milliseconds: 500),
            ),
          );
        }
        return SafeArea(
          child: Scaffold(
            body: ListView(
              children: snapshot.data.docs.map(
                (DocumentSnapshot document) {
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                              'assets/${document.data()['Catagery']}.png'),
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    String name = 'Error';
                                    String number = 'Unable to fatch User data';
                                    try {
                                      var data = await FirebaseFirestore
                                          .instance
                                          .collection(
                                              document.data()['Catagery'])
                                          .doc(document.data()['emailid'])
                                          .get();

                                      name = data.data()['Full Name'];
                                      number = data.data()['Contact'];
                                    } catch (e) {}
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(name),
                                          content: Text(number),
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    document.data()['emailid'],
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Text(
                                  document.data()['Description'],
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  document.data()['Date'],
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              TextButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('Complaints')
                                      .doc('${document.id}')
                                      .update({'Status': 'In Process'})
                                      .then((value) => print('Viewed'))
                                      .catchError(
                                        (error) => print(error),
                                      );
                                },
                                child: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.orange,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('Complaints')
                                      .doc('${document.id}')
                                      .update({'Status': 'Completed'})
                                      .then((value) => print('Done'))
                                      .catchError(
                                        (error) => showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Alart(
                                                content: error,
                                              );
                                            }),
                                      );
                                },
                                child: Icon(
                                  Icons.done_all,
                                  color: Colors.green,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('Solved')
                                      .doc('${document.id}')
                                      .set({
                                    'Status': 'Solved',
                                    'Date': (DateTime.now().toString())
                                        .substring(0, 11),
                                  });
                                  FirebaseFirestore.instance
                                      .collection('Complaints')
                                      .doc('${document.id}')
                                      .delete()
                                      .then((value) => print('Deleted'))
                                      .catchError(
                                        (error) => showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Alart(
                                                content: error,
                                              );
                                            }),
                                      );
                                },
                                child: Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      elevation: 10,
                      color: (document.data()['Status'] == 'Submitted'
                          ? Colors.white
                          : (document.data()['Status'] == 'In Process'
                              ? Colors.orange.shade100
                              : Colors.green.shade100)),
                      shadowColor: (document.data()['Status'] == 'Submitted'
                          ? Colors.white
                          : (document.data()['Status'] == 'In Process'
                              ? Colors.orange.shade100
                              : Colors.green.shade100)),
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.logout),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }
}

// InkWell(
//                     child: ListTile(
//                       title: Text(document.data()['Description']),
//                       subtitle: Text(document.data()['emailid']),
//                       onTap: () {
//                         print('Hello Bro');
//                       },
//                     ),
//                   );

// Card(
//                     elevation: 5,
//                     margin: EdgeInsets.all(5),
//                     child: Column(
//                       // mainAxisAlignment: MainAxisAlignment.center,
//                       // crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         TextButton(
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.resolveWith(
//                                 (states) => Colors.grey[50]),
//                             overlayColor: MaterialStateProperty.resolveWith(
//                                 (states) => Colors.blue[100]),
//                           ),
//                           onPressed: () {},
//                           child: Text(
//                             document.data()['emailid'],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Text(document.data()['Description']),
//                         Text(document.data()['Date']),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         ElevatedButton(
//                           onPressed: () {},
//                           child: Text('Review'),
//                         ),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         ElevatedButton(
//                           onPressed: () {},
//                           child: Text('Solved'),
//                         ),
//                       ],
//                     ),
//                   );

//  child: Card(
//             color: Colors.green.shade50,
//             elevation: 5,
//             child: Column(
//               children: [
//                 ListTile(
//                   selected: true,
//                   selectedTileColor: Colors.blueGrey.shade50,
//                   focusColor: Colors.blueGrey.shade300,
//                   hoverColor: Colors.green.shade200,
//                   leading: Image.asset('assets/${document.data()['Catagery']}.png'),
//                   shape: RoundedRectangleBorder(),
//                   contentPadding: EdgeInsets.symmetric(
//                       horizontal: 20, vertical: 5),
//                   title: Text(
//                     document.data()['emailid'],
//                   ),
//                   subtitle: Text(document.data()['Date']),
//                   trailing: Wrap(
//                     children: [
//                       TextButton(
//                         onPressed: () {},
//                         child: Icon(Icons.remove_red_eye),
//                       ),
//                       TextButton(
//                         onPressed: () {},
//                         child: Icon(Icons.done_all),
//                       )
//                     ],
//                   ),
//                 ),
//                 Text(document.data()['Description']),
//               ],
//             ),
//           ),
