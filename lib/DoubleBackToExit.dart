import 'package:flutter/material.dart';

class DoubleBackToExit extends StatefulWidget {
  final Widget child;

  const DoubleBackToExit({required this.child});

  @override
  _DoubleBackToExitState createState() => _DoubleBackToExitState();
}

class _DoubleBackToExitState extends State<DoubleBackToExit> {
  DateTime? lastPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (lastPressed == null || now.difference(lastPressed!) > Duration(seconds: 2)) {
          lastPressed = now;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Tekan sekali lagi untuk keluar'),
              duration: Duration(seconds: 2),
            ),
          );
          return Future.value(false); // Prevents the app from closing
        }
        return Future.value(true); // Allows the app to close
      },
      child: widget.child,
    );
  }
}