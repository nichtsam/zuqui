import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

Future<void> snackBar(String text) async {
  await Future.delayed(Duration.zero);
  final scaffoldMessenger = rootScaffoldMessengerKey.currentState;
  if (scaffoldMessenger == null) {
    throw Exception("snackBar only available under rootScaffoldMessengerKey.");
  }

  scaffoldMessenger.clearSnackBars();
  scaffoldMessenger.showSnackBar(SnackBar(content: Text(text)));
}
