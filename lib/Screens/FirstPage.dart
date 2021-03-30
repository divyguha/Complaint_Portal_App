import 'package:complaint_portal_app/Components/CatCard.dart';
import 'package:complaint_portal_app/Components/Sheet.dart';
import 'package:flutter/material.dart';

enum catagery { ADMIN, STUDENT, TEACHER }

class FirstPage extends StatelessWidget {
  static String id = 'First Page';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          leading: Image.asset('assets/SATI.jpg'),
          backgroundColor: Colors.white,
          title: Text(
            'SATI Complaint Portal',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            Sheet(),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
                    child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CatCard(
                  type: 'Student',
                ),
                CatCard(
                  type: 'Teacher',
                ),
                CatCard(
                  type: 'Admin',
                ),
              ],
            ),
          ),
        ),
        
      ),
    );
  }
}
