import 'package:complaint_portal_app/Utility/GetData.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  static String id = 'Admin Page';
  @override
  Widget build(BuildContext context) {
    return Information();

//     return Scaffold(
//       body: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           InkWell(
//             child: Card(
//               child: Text('Get Complaints'),
//             ),
//             onTap: () {
//               // Reterive().getComplents();
//             },
//           ),
//           InkWell(
//             child: Card(
//               child: Text('Solved Complaint'),
//             ),
//             onTap: () {},
//           ),
//         ],
//       ),
//     );
  }
}
