import 'dart:async';
import 'package:flutter/material.dart';
import 'onboardingscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      routes: {
        '/onboardingscreen': (context) => OnBoardingScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
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
      Duration(seconds: 7),
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
            SizedBox(height: 16.0),
            Text.rich(
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
