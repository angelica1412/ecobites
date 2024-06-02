import 'package:flutter/material.dart';

class PengaturanAkun extends StatelessWidget {
  const PengaturanAkun({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Add your back button action here
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      // Add your change profile picture action here
                    },
                    child: const Text('Change Profile Picture'),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(thickness: 1),
            ),
            const ListTile(
              title: Text('Profile Information'),
              dense: true,
            ),
            ListTile(
              title: const Text('Name'),
              subtitle: const Text('yournamehere'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Add your action here
              },
            ),
            ListTile(
              title: const Text('Store Name'),
              subtitle: const Text('yourstorenamehere'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Add your action here
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(thickness: 1),
            ),
            const ListTile(
              title: Text('Personal Information'),
              dense: true,
            ),
            ListTile(
              title: const Text('E-mail'),
              subtitle: const Text('youremail@ecobites.com'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Add your action here
              },
            ),
            ListTile(
              title: const Text('Phone Number'),
              subtitle: const Text('+62yourphonenumber'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Add your action here
              },
            ),
            ListTile(
              title: const Text('Gender'),
              subtitle: const Text('Male'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Add your action here
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your logout action here
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
