import 'package:ecobites/services/auth.dart';
import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  const Home({super.key});
  // Fungsi untuk logout pengguna
  Future<void> _logout(BuildContext context) async {
    await Auth.logout(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Home Screen!',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _logout(context); // Panggil fungsi logout saat tombol logout ditekan
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}


