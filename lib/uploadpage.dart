import 'package:ecobites/historypage.dart';
import 'package:ecobites/homepage.dart';
import 'package:flutter/material.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        currentIndex: 1, // Set the current index to indicate the Upload tab
        onTap: (int index) {
          if (index == 0) {
            // Navigate to Home page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()), // Ganti HomePage dengan halaman yang sesuai
            );
          } else if (index == 2) {
             // Navigate to Home page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HistoryPage()), // Ganti HomePage dengan halaman yang sesuai
            );
          }
        },
      ),
    );
  }
}
