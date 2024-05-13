import 'dart:async';
import 'package:ecobites/Store.dart';
import 'package:ecobites/UploadBarang.dart';
import 'package:ecobites/profile.dart';
import 'package:ecobites/tau.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'onboardingscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: 'AIzaSyCEmE75DispSxV_17bFkeRCTdhXFn5e60U', appId: '1:187615014655:android:278a9f8db6c682264be6ca', messagingSenderId: '187615014655', projectId: "ecobites-57b68"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      routes: {
        '/onboardingscreen': (context) => const OnBoardingScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

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
        Navigator.pushReplacementNamed(context, '/onboardingscreen');
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
              'assets/logo.png', // Replace 'logo.png' with your actual logo image path
              width: 180.0, // Adjust the width as needed
              height: 180.0, // Adjust the height as needed
            ),
            const SizedBox(height: 16.0),
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Eco',
                    style: TextStyle(
                      color: Colors.black, // Warna untuk bagian "Eco"
                      fontSize: 24, // Ukuran teks untuk bagian "Eco"
                      fontWeight:
                          FontWeight.bold, // Ketebalan teks untuk bagian "Eco"
                    ),
                  ),
                  TextSpan(
                    text: 'Bites',
                    style: TextStyle(
                      color: Colors.green, // Warna untuk bagian "Bites"
                      fontSize: 24, // Ukuran teks untuk bagian "Bites"
                      fontWeight: FontWeight
                          .bold, // Ketebalan teks untuk bagian "Bites"
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
