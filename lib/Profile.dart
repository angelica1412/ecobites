import 'package:ecobites/homepage.dart';
import 'package:ecobites/services/auth.dart';
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
  String? userName;
  String? userEmail;
  String? userPhoneNumber;
  bool _isLoading = true;
  bool _isPressed = false;

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
          userName = userDetails['username'];
          userPhoneNumber = userDetails['phone'];
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        // centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        elevation: 0,
        backgroundColor: Color(0xFFFAFAFA),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(
                          //   width: 25,
                          // ),
                          Container(
                            child: Row(
                              children: [
                                Center(
                                  child: Image.asset(
                                    'assets/defaultProfilePicture.png',
                                    height: 75,
                                    width: 75,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _getTrimmedText('$userName', 15),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        _getTrimmedText('$userEmail',
                                            20), // Call the method to trim text
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        '$userPhoneNumber',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PengaturanAkun(),
                                  ),
                                );
                              },
                              onTapDown: (details) {
                                setState(() {
                                  _isPressed = true;
                                });
                              },
                              onTapUp: (details) {
                                setState(() {
                                  _isPressed = false;
                                });
                              },
                              onTapCancel: () {
                                setState(() {
                                  _isPressed = false;
                                });
                              },
                              child: Icon(
                                CupertinoIcons.create,
                                size: 25,
                                color: _isPressed ? Colors.grey : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 350,
                      child: Divider(
                        thickness: 1.5,
                      ),
                    ),
                    SizedBox(height: 20),
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
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 0),
                                  child: Icon(
                                    CupertinoIcons.create,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 25),
                                  child: Text(
                                    'Edit Profile',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 95),
                                  child: Icon(
                                    CupertinoIcons.right_chevron,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                )
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
                            final currentUser =
                                FirebaseAuth.instance.currentUser;
                            if (currentUser != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      userStorePage(storeID: currentUser.uid),
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
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.tag,
                                  size: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 25),
                                  child: Text(
                                    'Toko Saya',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 95),
                                    child: Icon(
                                      CupertinoIcons.right_chevron,
                                      size: 20,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  String _getTrimmedText(String? text, int maxLength) {
    if (text == null) {
      return '';
    }
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + '...';
    }
  }
}
