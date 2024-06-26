import 'package:ecobites/user_store_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authenticate/Controller/userController.dart';

import 'PengaturanAkun.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userFirstName;
  String? userLastName;
  String? userEmail;
  String? userPhoneNumber;
  bool _isLoading = true;

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
          _isLoading=false;
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


  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black,
          fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        elevation: 0,
        backgroundColor: Color(0xFFFAFAFA),
      ),
      body: _isLoading?  Center(child: CircularProgressIndicator())
      :
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Image.asset(
                  'assets/defaultProfilePicture.png',
                  height: 200,
                  width: 200,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '$userFirstName $userLastName',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '$userEmail',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '$userPhoneNumber',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 56),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PengaturanAkun(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF92E3A9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pengaturan Akun',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.right_chevron,
                            size: 20,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 14),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      final currentUser = FirebaseAuth.instance.currentUser;
                      if (currentUser != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => userStorePage(storeID: currentUser.uid),
                          ),
                        );
                      } else {
                        // Handle the case where the user is not logged in
                        // For example, show a dialog or navigate to a login screen
                        print('User not logged in');
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF92E3A9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Toko Saya',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            CupertinoIcons.right_chevron,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}