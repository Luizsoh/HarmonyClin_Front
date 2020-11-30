import 'package:flutter/material.dart';

alert(BuildContext context, String msg, String titulo) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text(titulo)),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
                child: Text(
                  'Ok',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        );
      });
}
