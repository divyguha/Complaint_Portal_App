import 'package:complaint_portal_app/Screens/FirstPage.dart';
import 'package:flutter/material.dart';

class MyBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: TextButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, FirstPage.id);
        },
        icon: Icon(
          Icons.home_filled,
          color: Colors.black,
        ),
        label: Text(''),
      ),
    );
  }
}
