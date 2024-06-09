import 'package:ecobites/Profile.dart';
import 'package:ecobites/authenticate/Controller/userController.dart';
import 'package:flutter/material.dart';

class PengaturanAkun extends StatefulWidget {
  const PengaturanAkun({super.key});

  @override
  State<PengaturanAkun> createState() => _PengaturanAkunState();
}

class _PengaturanAkunState extends State<PengaturanAkun> {
  String? userFirstName;
  String? userLastName;
  String? userEmail;
  String? userPhoneNumber;
  bool _isLoading = true;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      final userDetails = await getUserDetailsbyUID();
      if (userDetails != null) {
        print('User Details: $userDetails');
        setState(() {
          userEmail = userDetails['email'];
          userFirstName = userDetails['firstName'];
          userLastName = userDetails['lastName'];
          userPhoneNumber = userDetails['phone'];

          _emailController.text = userEmail!;
          _firstNameController.text = userFirstName!;
          _lastNameController.text = userLastName!;
          _phoneController.text = userPhoneNumber!;

          _isLoading = false;
        });
      } else {
        print('User details not found');
        setState(() {
          _isLoading = false; // Mengubah status loading menjadi false jika data tidak ditemukan
        });
      }
    } catch (e) {
      print('Error fetching user details: $e');
      setState(() {
        _isLoading = false; // Mengubah status loading menjadi false jika terjadi error
      });
    }
  }

  Future<void> updateUserDetails() async {
    try {
      final updatedDetails = {
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
      };
      await updateUserDetailsbyUID(updatedDetails);
      print('User details updated successfully');
    } catch (e) {
      print('Error updating user details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ),
            );
          },
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(thickness: 1),
                  ),
                  const ListTile(
                    title: Text('Profile Information'),
                    dense: true,
                  ),
                  Container(
                    width: 350,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Column untuk Full Name
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('First Name: '),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _firstNameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                labelText: 'Nama Depan',
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16), // Add some spacing between the columns
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Last Name: '),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _lastNameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                labelText: 'Nama Belakang',
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16), // Add some spacing between the columns
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Your Email: '),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                labelText: 'Email Anda',
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16), // Add some spacing between the columns
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Your Phone Number: '),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                labelText: 'Nomor Telepon Anda',
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              await updateUserDetails();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Profile updated successfully!')),
                              );
                            },
                            child: const Text('Save Changes'),
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
