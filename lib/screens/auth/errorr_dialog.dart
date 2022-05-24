// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

Future<void> errorDialog(
    BuildContext context, Map<String, dynamic> response) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(response['message']),
          actions: [
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
