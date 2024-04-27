import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Page'),
      ),
      body: Center(
        child: Text(
          'This is the Upload Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
