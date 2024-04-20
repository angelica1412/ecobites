import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'authenticate/Controller/userController.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userEmail;
  String? userFirstName;
  String? userLastName;

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    final userDetails = await getUserDetailsbyUID();
    setState(() {
      userEmail = userDetails?['email'];
      userFirstName = userDetails?['firstName'];
      userLastName = userDetails?['lastName'];
      _firstNameController.text = userFirstName ?? '';
      _lastNameController.text = userLastName ?? '';
    });
  }

  Future<void> updateUserDetails(BuildContext context) async {
    Map<String, dynamic> userData = {
      'firstName' : _firstNameController.text.trim(),
      'lastName' : _lastNameController.text.trim(),
    };

    try {
      await updateUserDetailsbyUID(userData);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User details updated successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update user details')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Email: ${userEmail ?? 'Loading...'}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:(){
                updateUserDetails(context);
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
