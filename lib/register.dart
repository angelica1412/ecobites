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
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedProvince;

  // List of provinces for the dropdown menu
  final List<String> provinces = [
    'Sulawesi Selatan',
    'Sulawesi Utara',
    'Jawa Timur',
    'Jawa Barat',
    'Kalimantan Timur',
    // Add more provinces as needed
  ];

  Future<void> registration(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> userData = {
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'email': emailController.text.trim(),
        'address': addressController.text.trim(),
        'phone': phoneController.text.trim(),
      };
      await Auth.registerUser(
          context, emailController.text.trim(), passController.text.trim());
      await addUserDetailsToFirestore(userData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter your username, email, and password correctly to create a new account.',
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
                  ),
                ),
                const SizedBox(height: 20),
                const Text('First Name',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10), // Added space
                TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontSize: 16),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF92E3A9), width: 2.0),
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
                const Text('Last Name',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10), // Added space
                TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontSize: 16),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF92E3A9), width: 2.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                const Text('Email',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10), // Added space
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontSize: 16),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF92E3A9), width: 2.0),
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
                const Text('Password',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10), // Added space
                TextFormField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontSize: 16),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF92E3A9), width: 2.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                const Text('Address',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10), // Added space
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontSize: 16),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF92E3A9), width: 2.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                const Text('Phone Number',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10), // Added space
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(fontSize: 16),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF92E3A9), width: 2.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text('Province',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  value: selectedProvince,
                  onChanged: (newValue) {
                    setState(() {
                      selectedProvince = newValue.toString();
                    });
                  },
                  items: provinces.map((province) {
                    return DropdownMenuItem(
                      value: province,
                      child: Text(province),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelStyle: TextStyle(fontSize: 16),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF92E3A9), width: 2.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () => registration(context),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF92E3A9),
                      minimumSize: Size(
                          200, 50), // Menetapkan ukuran minimum untuk button
                    ),
                    child: Text('Sign Up', style: TextStyle(fontSize: 20)),
                  ),
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
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
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