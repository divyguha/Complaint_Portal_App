import 'package:flutter/material.dart';

class Alart extends StatelessWidget {
  final String title;
  final String content;
  const Alart({this.content, this.title = 'Error'});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
    );
  }
}
