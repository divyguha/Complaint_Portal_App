import 'package:flutter/material.dart';

class Wrong extends StatelessWidget {
  static String id = 'Went Wrong';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        content: Text('Something Went Wrong'),
        title: Text('Error'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Try Again'),
          )
        ],
      ),
    );
  }
}

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('wait');
  }
}
