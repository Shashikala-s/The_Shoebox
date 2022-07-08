import 'package:flutter/material.dart';

class AppScaffoldMessenger {
  void errorMsg(BuildContext context, String e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red[400],
      content: Container(
          child: Text(
        e,
        style:
            Theme.of(context).textTheme.subtitle2!.apply(color: Colors.white),
      )),
    ));
  }

  void successMsg(BuildContext context, String e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.green[400],
      content: Text(
        e,
        style:
            Theme.of(context).textTheme.subtitle2!.apply(color: Colors.white),
      ),
    ));
  }
}
