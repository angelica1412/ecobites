import 'package:ecobites/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home.dart';
import '../login.dart';

class Auth {
//login application
  static Future<void> login(BuildContext context, String email, String password) async {
    // Lakukan proses login di sini
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.amber,
            content: Text(
              "No User Found",
              style: TextStyle(fontSize: 18.0),
            )));
      } else if (e.code == 'invalid-credential') {
        // Use Builder widget to ensure correct context
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.amber,
            content: Text(
              "Wrong email or password",
              style: TextStyle(fontSize: 18.0),
            ),
        ),
        );
      }else if (e.code == 'too-many-requests') {
        // Use Builder widget to ensure correct context
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.amber,
            content: Text(
              "Please try again later",
              style: TextStyle(fontSize: 18.0),
            )));
      }else if (e.code == 'invalid-email') {
        // Use Builder widget to ensure correct context
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.amber,
            content: Text(
              "invalid Email",
              style: TextStyle(fontSize: 18.0),
            )));
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.amber,
            content: Text(
              "Error",
              style: TextStyle(fontSize: 18.0),
            )));
        print('Eror: $e');
      }
    }catch(e){
      print('Eror: $e');
    }
  }
  //Register application
  static Future<void> registerUser(BuildContext context, String email, String password) async {

      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password

        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Registered Successfully",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
        // Setelah registrasi berhasil, Anda dapat melakukan navigasi ke halaman beranda atau yang diinginkan
        // Misalnya:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.amber,
              content: Text(
                "Password weak",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          );
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.amber,
              content: Text(
                "Account already exists",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          );
        }
      }
  }
  //logout
  static Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut(); // Lakukan proses logout
      Navigator.pushReplacement( // Navigasi kembali ke layar login setelah logout berhasil
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      // Tangani jika terjadi kesalahan saat proses logout
      print("Error during logout: $e");
      // Anda dapat menampilkan pesan kesalahan atau melakukan tindakan lain sesuai kebutuhan aplikasi Anda
    }
  }
    // Lakukan proses logout di sini
    // Misalnya, keluarkan pengguna dari sesi Firebase Auth

    // Atur status login menjadi false
//keep login
  static void checkUserLoginStatus(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Jika pengguna sudah masuk sebelumnya, arahkan ke layar beranda
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else{
      // Jika pengguna belum masuk, arahkan ke layar login
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SplashScreen(),
      )
      );
    }
  }
}
