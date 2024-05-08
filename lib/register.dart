import 'package:ecobites/authenticate/Controller/userController.dart';
import 'package:ecobites/services/auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> registration(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> userData = {
        'firstName' : firstNameController.text.trim(),
        'lastName' : lastNameController.text.trim(),
        'email' : emailController.text.trim() ,
      };
        await Auth.registerUser(context, emailController.text.trim(), passController.text.trim());
        await addUserDetailsToFirestore(userData);
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF92E3A9),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: const Color(0xFFFAFAFA),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create an Account',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE8AE45),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter your username, email, and password correctly to create a new account',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF838181),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    'assets/register.png',
                    height: 300,
                    width: 300,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const SizedBox(height: 10),
                            TextFormField(
                              controller: firstNameController,
                              decoration: const InputDecoration(
                                labelText: 'First Name',
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xFFE8AE45), width: 2.0),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                          ],
                        )
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            TextFormField(
                              controller: lastNameController,
                              decoration: const InputDecoration(
                                labelText: 'Last Name',
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xFFE8AE45), width: 2.0),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                            ),
                          ],
                        )
                    ),
                ],
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE8AE45), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: passController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE8AE45), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    registration(context);


                  },
                  child: const Text('Register'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF92E3A9),
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
    );
  }
}