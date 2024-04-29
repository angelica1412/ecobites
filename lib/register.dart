import 'package:flutter/material.dart';
import 'login.dart';
// import 'completeAkun.dart';

class RegisterPage extends StatelessWidget {
  // List of countries for the dropdown menu
  final List<String> province = [
    'Sulawesi Selatan',
    'Sulawesi Utara',
    'Jawa Timur',
    'Jawa Barat',
    'Kalimantan Timur',
    // Add more countries as needed
  ];

  // Selected province value
  String? selectedProvince;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Back'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF92E3A9),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Color(0xFFFAFAFA),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Tambahkan SingleChildScrollView di sini
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create an Account',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 137, 208, 157),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Enter your username, email, password, address, phone number, and province to create a new account',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF838181),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Image.asset(
                  'assets/register.png',
                  height: 300,
                  width: 300,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Full Name',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Full Name',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 137, 208, 157), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Email',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: 'youremail@example.com',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 137, 208, 157), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '**************',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFE8AE45), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Phone Number',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: '123-456-7890',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 137, 208, 157), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Address',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Your Address',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 137, 208, 157), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Province',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // Dropdown menu for countries
              DropdownButtonFormField(
                value: selectedProvince,
                onChanged: (newValue) {
                  // Update the selected province when user selects from dropdown
                  selectedProvince = newValue.toString();
                },
                items: province.map((province) {
                  return DropdownMenuItem(
                    value: province,
                    child: Text(province),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigasi ke halaman pendaftaran
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 137, 208, 157),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Submit', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigasi ke halaman pendaftaran
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      // Navigasi ke halaman pendaftaran
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Sign In',
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
    );
  }
}
