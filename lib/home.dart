import 'package:ecobites/Store.dart';

import 'package:ecobites/user_store_page.dart';
import 'package:flutter/material.dart';
import 'package:ecobites/services/auth.dart';

import 'Widgets/ProductCard.dart';
import 'package:ecobites/authenticate/Controller/storeController.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  // Function to log out the user
  Future<void> _logout(BuildContext context) async {
    await Auth.logout(context);

  }

  @override
  Widget build(BuildContext context) {
    List<Product> store = [
      Product(
        name: 'Product 1',
        description: 'Description for Product 1',
        price: 15000,
        imageURL: 'assets/product1.png',
        category: 'Food',
      ),
      Product(
        name: 'Product 3',
        description: 'Description for Product 2',
        price: 20000,
        imageURL: 'assets/product2.png',
        category: 'Bahan',
      ),
      Product(
        name: 'Product 2',
        description: 'Description for Product 2',
        price: 5000,
        imageURL: 'assets/product3.png',
        category: 'Daur',

      ),
      Product(
        name: 'Product 4',
        description: 'Description for Product 2',
        price: 7000,
        imageURL: 'assets/login.png',
        category: 'Bahan',

      ),
      Product(
        name: 'Product 4',
        description: 'Description for Product 2',
        price: 2000,
        imageURL: 'assets/login.png',
        category: 'Daur',
      ),
      Product(
        name: 'Product 4',
        description: 'Description for Product 2',
        price: 1000,
        imageURL: 'assets/login.png',
        category: 'Daur',
      ),
      Product(
        name: 'Product 4',
        description: 'Description for Product 2',
        price: 2305,
        imageURL: 'assets/login.png',
        category: 'Daur',
      ),
      // Add more products as needed
    ];
    return Scaffold(

      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Home Screens!',
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
            icon: Icon(Icons.store_mall_directory),
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
              MaterialPageRoute(builder: (context) => const userStorePage()),
            );
          }else if (index ==2){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StorePage()),
            );
          }
        },
      ),
    );
  }
}
