import 'dart:io';
import 'package:ecobites/authenticate/Controller/userController.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PengaturanAkun extends StatefulWidget {
  const PengaturanAkun({super.key});

  @override
  State<PengaturanAkun> createState() => _PengaturanAkunState();
}

class _PengaturanAkunState extends State<PengaturanAkun> {
  bool _isLoading = true;
  File? _imageFile;
  String? _imageURL;



  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    setState(() {
      _isLoading=true;
    });
    try {
      final userDetails = await getUserDetailsbyUID();
      if (userDetails != null) {
        print('User Details: $userDetails');
        setState(() {
          _imageURL = userDetails['userImageURL'];
          _emailController.text = userDetails['email'] ?? '';
          _phoneController.text = userDetails['phone'] ?? '';
          _usernameController.text = userDetails['username'] ?? '';

          _isLoading = false;
        });
      } else {
        print('User details not found');
        setState(() {
          _isLoading =
              false; // Mengubah status loading menjadi false jika data tidak ditemukan
        });
      }
    } catch (e) {
      print('Error fetching user details: $e');
      setState(() {
        _isLoading =
            false; // Mengubah status loading menjadi false jika terjadi error
      });
    }
  }
  Future<void> _pickImageFromGallery() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        print(_imageFile);
      }
    });
  }
  Future<void> updateUserDetails() async {
    try {
      final updatedDetails = {
        'username': _usernameController.text,
        'phone': _phoneController.text,
      };
      await updateUserDetailsbyUID(updatedDetails, _imageFile);
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
            Navigator.pop(context, true);
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
                        if(_imageFile != null)
                          ClipOval(
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.file(
                                _imageFile!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        else if(_imageURL != null)
                          ClipOval(
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.network(
                                _imageURL!,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    height: 120,
                                    width: double.infinity,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                  return const Icon(Icons.error);
                                },

                              ),
                            ),
                          )
                        else if (_imageURL == null && _imageFile == null)
                          const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                            child:
                                Icon(Icons.person, size: 50, color: Colors.white),
                          ),
                        TextButton(
                          onPressed: _pickImageFromGallery,
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Column untuk Full Name
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Username: ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                              height: 16), // Add some spacing between the columns
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Your Email: '),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _emailController,
                                enabled: false,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  hintText: '$_emailController',
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                              height: 16), // Add some spacing between the columns
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Your Phone Number: '),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _phoneController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  hintText: '$_phoneController',
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await updateUserDetails();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Profile updated successfully!')),
                                  );
                                },
                                child: const Text('Save Changes'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50,),

                          const SizedBox(height: 50,),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
