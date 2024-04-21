import 'package:ecobites/Store.dart';
import 'package:ecobites/profile.dart';
import 'package:flutter/material.dart';
import 'package:ecobites/services/auth.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  // Function to log out the user
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
                _logout(context); // Call the logout function when the logout button is pressed
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
        ],
        currentIndex: 0, // You can set this value based on which page you're currently on
        onTap: (int index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }else if (index ==2){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StorePage()),
            );
          }
        },
      ),
    );
  }
}
