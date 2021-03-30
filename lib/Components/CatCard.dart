import 'package:complaint_portal_app/Screens/LogInPage.dart';
import 'package:flutter/material.dart';

class CatCard extends StatelessWidget {
  final String type;
  CatCard({this.type});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          LogIN.id,
          arguments: LogIN(
            type: type,
          ),
        );
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.only(left: 30,bottom: 10,top: 10,right: 10),
        shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(30),
        ),
        shadowColor: Colors.green,
        child: Column(
          children: [
            Image.asset('assets/$type.png'),
            Text(type,style: TextStyle(fontWeight: FontWeight.w900),),
          ],
        ),
      ),
    );
  }
}
