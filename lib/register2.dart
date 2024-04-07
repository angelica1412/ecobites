

import 'dart:js';

import 'package:ecobites/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';
// import 'completeAkun.dart';

class RegisterPage extends StatelessWidget {

  String email='',password='',firstName='',lastName='';
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passcontroller = new TextEditingController();
  TextEditingController firstNamecontroller = new TextEditingController();
  TextEditingController lastNamecontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration(BuildContext context)async{
    if(password!=null && lastNamecontroller.text!=''&&firstNamecontroller.text!=''&& emailcontroller.text!=''&&passcontroller.text!=''){
      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registered Succesfully", style: TextStyle(fontSize: 20.0))));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()) );
      }on FirebaseAuthException catch(e){
        if(e.code=='weak-password'){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.amber, content: Text("Password weak", style: TextStyle(fontSize: 20.0))));
        }else if(e.code=="email-already-in-use"){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.amber, content: Text("Account already exist", style: TextStyle(fontSize: 20.0))));

        }
      }
    }
  }
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
        child: Form(
          key: _formkey,
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
                    color: Color(0xFFE8AE45),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Enter your username, email, and password correctly to create a new account',
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
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Full Name',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            validator: (value){
                              if(value==null||value.isEmpty){
                                return 'Please Enter First Name';
                              }
                              return null;
                            },
                            controller: firstNamecontroller,
                            decoration: InputDecoration(
                              hintText: 'First Name',
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
                          ),
                              SizedBox(height: 10),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Last Name',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            validator: (value){
                              if(value==null||value.isEmpty){
                                return 'Please Enter Last Name';
                              }
                              return null;
                            },
                            controller: lastNamecontroller,
                            decoration: InputDecoration(
                              hintText: 'Last Name',
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
                          ),
                        ],
                      ),
                    ),
                  ],
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
                TextFormField(
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return 'Please Enter email';
                    }
                    return null;
                  },
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    hintText: 'youremail@example.com',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE8AE45), width: 2.0),
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
                TextFormField(
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                  controller: passcontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: '**************',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE8AE45), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 150,
                    // child: ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => CompleteProfilePage()),
                    //     );
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     primary: Color(0xFFE8AE45),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(30.0),
                    //     ),
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(16.0),
                    //     child: Text('Continue', style: TextStyle(fontSize: 18)),
                    //   ),
                    // ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(_formkey.currentState!.validate()){
                          setState((){
                            email=emailcontroller.text;
                            password=passcontroller.text;
                            firstName=firstNamecontroller.text;
                            lastName=lastNamecontroller.text;
                          });
                        }
                        registration(context);
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
                        if(_formkey.currentState!.validate()){
                          setState((){
                            email='enrico@gmail.com';
                            password='blbalbla123(';
                            firstName='enrico';
                            lastName='kevvin';
                          });
                        }
                        registration(context);
                        // Navigasi ke halaman pendaftaran
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
      ),
    );
  }

  void setState(Null Function() param0) {}
}
