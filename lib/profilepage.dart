import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Page'),
      ),
      body: const Center(
        child: Text(
          'This is the Upload Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
