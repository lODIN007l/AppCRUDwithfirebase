import 'package:flutter/material.dart';

class NotificationService {
  static GlobalKey<ScaffoldMessengerState> messengerK =
      GlobalKey<ScaffoldMessengerState>();

  static ShowSnackBAR(String message) {
    final snackBAR = SnackBar(
        content: Text(
      message,
      style: TextStyle(color: Colors.white, fontSize: 20),
    ));
    messengerK.currentState!.showSnackBar(snackBAR);
  }
}
