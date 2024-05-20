import 'package:ecobites/Store.dart';
import 'package:ecobites/historypage.dart';
import 'package:ecobites/profile.dart';
import 'package:ecobites/voucherPage.dart';
import 'package:flutter/material.dart';

import 'UploadBarang.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? usedVoucherCode;
  bool isVoucherUsed = false;
  Color searchIconColor = Colors.grey;// State variable for search icon color
  void _handleVoucherUsed(Voucher voucher) {
    setState(() {
      isVoucherUsed = false;
      usedVoucherCode='';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 255, 255, 255),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 80,
                    width: 80,
                  ),
                  Container(
                    padding: EdgeInsets.all(
                        2), // Menambahkan padding untuk memusatkan ikon
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                          255, 178, 178, 178), // Warna latar belakang
                      shape: BoxShape.circle, // Latar belakang bulat
                    ),
                    child: IconButton(
                      icon: Icon(Icons.person, size: 32),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                onTap: () {
                  setState(() {
                    searchIconColor =
                        const Color(0xFF92E3A9); // Change color when tapped
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search for food...',
                  prefixIcon: Icon(Icons.search, color: searchIconColor),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF92E3A9), width: 2.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child:
                    GestureDetector(
                  onTap:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=> StorePage()));},
                child: Container(
                      width: 160,
                      height: 200,
                      child: Card(
                        elevation: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/food.png',
                                height: 80, width: 80),
                            const SizedBox(height: 8),
                            const Text('Food'),
                          ],
                        ),
                      ),
                    ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      width: 160,
                      height: 200,
                      child: Card(
                        elevation: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/daurulang.png',
                                height: 80, width: 80),
                            const SizedBox(height: 8),
                            const Text('Bahan Daur Ulang'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: 160,
                  height: 200,
                  child: Card(
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/pupuk.png', height: 80, width: 80),
                        const SizedBox(height: 8),
                        const Text('Fertilizer'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF92E3A9)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VoucherPage(fromCheckout: false, onVoucherUsed: _handleVoucherUsed,)),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Voucher',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 130, height: 60),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Activity',
          ),
        ],
        currentIndex: 0, // Menetapkan indeks saat ini ke halaman Upload
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => UploadBarang()),
              ); // Pindah ke halaman Upload
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HistoryPage()),
              ); // Pindah ke halaman History
              break;
          }
        },
        selectedItemColor: const Color(
            0xFF92E3A9), // Mengubah warna item yang dipilih menjadi hijau
        unselectedItemColor: Colors
            .grey, // Mengubah warna item yang tidak dipilih menjadi abu-abu
      ),
    );
  }
}
