import 'package:flutter/material.dart';
import 'register.dart'; // Mengimpor file signup_page.dart
import 'package:ecobites/services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future<void> userLogin(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      await Auth.login(context, emailController.text.trim(), passController.text.trim());
      // Bring the user to the home page after successful login
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome Back!!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please login by using your email and password.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF838181),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    'assets/login.png',
                    height: 300,
                    width: 300,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value){
                        if(value==null||value.isEmpty){
                          return 'Please Enter Email';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: 'emailanda@gmail.com',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF92E3A9), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value){
                        if(value==null||value.isEmpty){
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                      controller: passController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: '**************',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF92E3A9), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        userLogin(context);
                        // Add your authentication logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF92E3A9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Login', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterPage()),
                        );
                      },
                      child: const Text(
                        'Don’t have an account?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the registration page
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterPage()),
                              (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFF92E3A9),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ),
          ),
        ),
      ),
    );
  }
}