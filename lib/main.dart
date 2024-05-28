import 'dart:async';
import 'package:ecobites/homepage.dart';
import 'package:ecobites/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'aftercheckout.dart'; // Import AfterCheckoutPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCEmE75DispSxV_17bFkeRCTdhXFn5e60U',
      appId: '1:187615014655:android:278a9f8db6c682264be6ca',
      messagingSenderId: '187615014655',
      projectId: "ecobites-57b68",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(), // Splash screen sebagai halaman awal
      // home: ChatPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/detail': (context) => HomePage(), // Routing untuk Onboarding Screen
        // '/aftercheckout': (context) => CheckoutPage(), // Add AfterCheckoutPage route
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a time-consuming task (e.g., loading data) for the splash screen.
    // Replace this with your actual data loading logic.
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacementNamed(context, '/onboardingscreen'); // Navigasi ke Onboarding Screen setelah beberapa waktu
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo.png', // Ganti dengan path logo yang sesuai
              width: 180.0, // Sesuaikan lebar logo
              height: 180.0, // Sesuaikan tinggi logo
            ),
            const SizedBox(height: 16.0),
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Eco',
                    style: TextStyle(
                      color: Colors.black, // Warna untuk "Eco"
                      fontSize: 24, // Ukuran teks untuk "Eco"
                      fontWeight: FontWeight.bold, // Ketebalan teks untuk "Eco"
                    ),
                  ),
                  TextSpan(
                    text: 'Bites',
                    style: TextStyle(
                      color: Colors.green, // Warna untuk "Bites"
                      fontSize: 24, // Ukuran teks untuk "Bites"
                      fontWeight: FontWeight.bold, // Ketebalan teks untuk "Bites"
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
